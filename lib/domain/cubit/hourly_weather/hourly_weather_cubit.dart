import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/common/flushbar_helper.dart';
import 'package:weather_station/core/domain/cubit/call_wrapper.dart';
import 'package:weather_station/core/domain/cubit/cubit_event.dart';
import 'package:weather_station/core/domain/cubit/cubit_state.dart';
import 'package:weather_station/core/domain/cubit/event_cubit.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/domain/entity/weather/weather.dart';
import 'package:weather_station/domain/repository/weather_repository.dart';

part 'hourly_weather_bloc.freezed.dart';

part 'hourly_weather_event.dart';

part 'hourly_weather_state.dart';

@injectable
class HourlyWeatherCubit
    extends EventCubit<HourlyWeatherEvent, HourlyWeatherState> {
  final WeatherRepository _weatherRepository;
  final FlushbarHelper _flushbarHelper;

  KtList<Weather> _fetchedWeathers;

  DateTime get _weatherDate => _fetchedWeathers[0].date;

  HourlyWeatherCubit(
    this._weatherRepository,
    this._flushbarHelper,
  ) : super(const HourlyWeatherState.initial(selectDateLoading: false));

  @override
  Future<void> onEvent(HourlyWeatherEvent event) async {
    await event.map(
      loadPressed: _mapLoadPressed,
      changeDatePressed: mapChangeDatePressed,
    );
  }

  Future<void> _mapLoadPressed(
    LoadPressed event,
  ) async {
    await callWrapper<KtList<Weather>>(
        call: _weatherRepository.fetchHourlyWeather(event.day),
        onProgress: () {
          emit(const Initial(selectDateLoading: true));
        },
        onSuccess: (weathers) {
          _fetchedWeathers = weathers;
          emit(RenderCharts(
            weathers: weathers,
            changeDateLoading: false,
          ));
        },
        onError: (message) {
          _flushbarHelper.showError(message: message);
          emit(const Initial(selectDateLoading: false));
        });
  }

  Future<void> mapChangeDatePressed(
    ChangeDatePressed event,
  ) async {
    if (event.day == _weatherDate) {
      return;
    }

    await callWrapper<KtList<Weather>>(
        call: _weatherRepository.fetchHourlyWeather(event.day),
        onProgress: () {
          final currentState = state as RenderCharts;
          emit(currentState.copyWith(changeDateLoading: true));
        },
        onSuccess: (weathers) {
          _fetchedWeathers = weathers;
          _flushbarHelper.showSuccess(message: Strings.dataUpdated);
          _fetchedWeathers = weathers;
          emit(RenderCharts(
            weathers: weathers,
            changeDateLoading: false,
          ));
        },
        onError: (message) {
          _flushbarHelper.showError(message: message);
          emit(RenderCharts(
            weathers: _fetchedWeathers,
            changeDateLoading: false,
          ));
        });
  }
}
