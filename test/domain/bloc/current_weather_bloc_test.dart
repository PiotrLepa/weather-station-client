import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_station/core/common/flushbar_helper.dart';
import 'package:weather_station/core/data/network/exception/api/api_exception.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/domain/bloc/current_weather/current_weather_bloc.dart';
import 'package:weather_station/domain/entity/weather/weather.dart';
import 'package:weather_station/domain/repository/weather_repository.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

class MockFlushbarHelper extends Mock implements FlushbarHelper {}

void main() {
  CurrentWeatherBloc bloc;
  MockWeatherRepository mockWeatherRepository;
  MockFlushbarHelper mockFlushbarHelper;

  final weather = Weather(
    temperature: 20,
    humidity: 60.5,
    pressure: 1000,
    pm1: 10.5,
    pm25: 25.3,
    pm10: 18.3,
    windSpeedAvg: 0.5,
    windSpeedMax: 10.3,
    rainGauge: 0.7,
    location: 'Tarnów',
    date: DateTime(2020, 8, 11),
  );

  setUpAll(() async {
    await configureInjection(Env.dev);
  });

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    mockFlushbarHelper = MockFlushbarHelper();
    bloc = CurrentWeatherBloc(mockWeatherRepository, mockFlushbarHelper);
  });

  blocTest<CurrentWeatherBloc, CurrentWeatherState>(
    'initial state is InitialLoading',
    build: () => bloc,
    verify: (bloc) => expect(bloc.state, const InitialLoading()),
  );

  blocTest<CurrentWeatherBloc, CurrentWeatherState>(
    'on PageStarted should fetch current weather from repository',
    build: () {
      when(mockWeatherRepository.fetchCurrentWeather())
          .thenAnswer((_) => Future.value(weather));

      return bloc;
    },
    act: (bloc) => bloc.add(const PageStarted()),
    verify: (bloc) {
      verify(mockWeatherRepository.fetchCurrentWeather()).called(1);
    },
  );

  blocTest<CurrentWeatherBloc, CurrentWeatherState>(
    'when fetch current weather fails should show error flushbar',
    build: () {
      when(mockWeatherRepository.fetchCurrentWeather())
          .thenAnswer((_) => Future.error(const NoConnection()));

      return bloc;
    },
    act: (bloc) => bloc.add(const PageStarted()),
    verify: (bloc) {
      verify(mockFlushbarHelper.showError(
              message: Strings.apiErrorNoConnection))
          .called(1);
    },
  );

  blocTest<CurrentWeatherBloc, CurrentWeatherState>(
    'on event PageStarted should emit [InitialLoading, RenderWeather] when fetch current weather is gotten successfully',
    build: () {
      when(mockWeatherRepository.fetchCurrentWeather())
          .thenAnswer((_) => Future.value(weather));

      return bloc;
    },
    act: (bloc) => bloc.add(const PageStarted()),
    expect: <CurrentWeatherState>[
      const InitialLoading(),
      RenderWeather(weather: weather, refreshLoading: false),
    ],
  );

  blocTest<CurrentWeatherBloc, CurrentWeatherState>(
    'on event PageStarted should emit [InitialLoading, RenderError] when fetch current weather fails',
    build: () {
      when(mockWeatherRepository.fetchCurrentWeather())
          .thenAnswer((_) => Future.error(const NoConnection()));

      return bloc;
    },
    act: (bloc) => bloc.add(const PageStarted()),
    expect: <CurrentWeatherState>[
      const InitialLoading(),
      const RenderError(message: Strings.fetchDataFailed, loading: false),
    ],
  );

  blocTest<CurrentWeatherBloc, CurrentWeatherState>(
      'on event RefreshPressed should not fetch weather if data is up-to-date',
      build: () {
    when(mockWeatherRepository.fetchCurrentWeather()).thenAnswer(
        (_) => Future.value(weather.copyWith(date: DateTime.now())));

    return bloc;
  }, act: (bloc) async {
    bloc.add(const PageStarted());
    await untilCalled(mockWeatherRepository.fetchCurrentWeather());
    bloc.add(const RefreshPressed());
  }, verify: (bloc) {
    verify(mockWeatherRepository.fetchCurrentWeather()).called(1);
  });

  blocTest<CurrentWeatherBloc, CurrentWeatherState>(
      'on event RefreshPressed should fetch weather if data obsolete',
      build: () {
    when(mockWeatherRepository.fetchCurrentWeather()).thenAnswer((_) =>
        Future.value(weather.copyWith(
            date: DateTime.now()
                .subtract(CurrentWeatherBloc.weatherFetchDelay))));

    return bloc;
  }, act: (bloc) async {
    bloc.add(const PageStarted());
    await untilCalled(mockWeatherRepository.fetchCurrentWeather());
    bloc.add(const RefreshPressed());
  }, verify: (bloc) {
    verify(mockWeatherRepository.fetchCurrentWeather()).called(2);
  });
}
