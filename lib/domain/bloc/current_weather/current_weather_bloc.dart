import 'package:auto_localized/auto_localized.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/common/flushbar_helper.dart';
import 'package:weather_station/core/domain/bloc/bloc_helper.dart';
import 'package:weather_station/core/domain/bloc/event_cubit.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/domain/entity/weather/weather.dart';
import 'package:weather_station/domain/repository/weather_repository.dart';

part 'current_weather_bloc.freezed.dart';
part 'current_weather_event.dart';
part 'current_weather_state.dart';

@injectable
class CurrentWeatherBloc
    extends EventCubit<CurrentWeatherEvent, CurrentWeatherState> {
  static const _weatherFetchDelayMinutes = 5;

  final WeatherRepository _weatherRepository;
  final FlushbarHelper _flushbarHelper;

  Weather _fetchedWeather;

  CurrentWeatherBloc(
    this._weatherRepository,
    this._flushbarHelper,
  ) : super(const CurrentWeatherState.initialLoading());

  @override
  Future<void> onEvent(CurrentWeatherEvent event) async {
    await event.map(
      pageStarted: _mapPageStarted,
      refreshPressed: _mapRefreshPage,
      retryPressed: _mapRetryPressed,
    );
  }

  Future<void> _mapPageStarted(PageStarted event,) async {
    await callWrapper<Weather>(
      call: _weatherRepository.fetchCurrentWeather(),
      onProgress: () => emit(const InitialLoading()),
      onSuccess: (result) {
        _fetchedWeather = result;
        emit(RenderWeather(
          weather: result,
          refreshLoading: false,
        ));
      },
      onError: (message) {
        _flushbarHelper.showError(message: message);
        emit(const RenderError(
          message: Strings.fetchDataFailed,
          loading: false,
        ));
      },
    );
  }

  Future<void> _mapRefreshPage(RefreshPressed event,) async {
    if (!_shouldRefreshWeather()) {
      _flushbarHelper.showSuccess(message: Strings.dataUpToDate);
      emit(CurrentWeatherState.renderWeather(
        weather: _fetchedWeather,
        refreshLoading: false,
      ));
      return;
    }

    await callWrapper<Weather>(
      call: _weatherRepository.fetchCurrentWeather(),
      onProgress: () {
        RenderWeather(
          weather: _fetchedWeather,
          refreshLoading: true,
        );
      },
      onSuccess: (weather) {
        _fetchedWeather = weather;
        _flushbarHelper.showSuccess(message: Strings.dataUpdated);
        emit(RenderWeather(
          weather: weather,
          refreshLoading: false,
        ));
      },
      onError: (message) {
        _flushbarHelper.showError(message: message);
        if (_fetchedWeather != null) {
          emit(RenderWeather(
            weather: _fetchedWeather,
            refreshLoading: false,
          ));
        } else {
          emit(const RenderError(
            message: Strings.fetchDataFailed,
            loading: false,
          ));
        }
      },
    );
  }

  bool _shouldRefreshWeather() =>
      _fetchedWeather == null ||
      (DateTime.now().difference(_fetchedWeather.date).inMinutes >=
          _weatherFetchDelayMinutes);

  Future<void> _mapRetryPressed(RetryPressed event,) async {
    await callWrapper<Weather>(
      call: _weatherRepository.fetchCurrentWeather(),
      onProgress: () {
        final errorState = state as RenderError;
        emit(errorState.copyWith(loading: true));
      },
      onSuccess: (weather) {
        _fetchedWeather = weather;
        emit(RenderWeather(
          weather: weather,
          refreshLoading: false,
        ));
      },
      onError: (message) {
        _flushbarHelper.showError(message: message);
        emit(const CurrentWeatherState.renderError(
          message: Strings.fetchDataFailed,
          loading: false,
        ));
      },
    );
  }
}
