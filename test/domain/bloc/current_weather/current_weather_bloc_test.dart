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

final weather = Weather(
  temperature: 20,
  humidity: 60.5,
  pressure: 1000,
  pm1: 10,
  pm25: 25,
  pm10: 18,
  windSpeedAvg: 0.5,
  windSpeedMax: 10.3,
  rainGauge: 0.7,
  address: 'Tarnów',
  dateTime: DateTime(2020, 8, 11),
);

void main() {
  CurrentWeatherBloc bloc;
  MockWeatherRepository mockWeatherRepository;
  MockFlushbarHelper mockFlushbarHelper;

  setUpAll(() async {
    await configureInjection();
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

  group('on PageStarted event', () {
    blocTest<CurrentWeatherBloc, CurrentWeatherState>(
      'should fetch current weather from repository',
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
      'should emit proper states when fetch current weather is gotten successfully',
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
      'should emit proper states when fetch current weather fails',
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
      'should show error flushbar when fetch current weather fails',
      build: () {
        when(mockWeatherRepository.fetchCurrentWeather())
            .thenAnswer((_) => Future.error(const NoConnection()));

        return bloc;
      },
      act: (bloc) => bloc.add(const PageStarted()),
      verify: (bloc) {
        verify(mockFlushbarHelper.showError(
          message: Strings.apiErrorNoConnection,
        )).called(1);
      },
    );
  });

  group('on RefreshPressed event', () {
    final currentTimeWeather = weather.copyWith(dateTime: DateTime.now());

    blocTest<CurrentWeatherBloc, CurrentWeatherState>(
      'should emit cached weather if data is up-to-date',
      build: () {
        when(mockWeatherRepository.fetchCurrentWeather())
            .thenAnswer((_) => Future.value(currentTimeWeather));

        return bloc;
      },
      act: (bloc) async {
        bloc.add(const PageStarted());
        await untilCalled(mockWeatherRepository.fetchCurrentWeather());
        bloc.add(const RefreshPressed());
      },
      expect: <CurrentWeatherState>[
        const InitialLoading(),
        RenderWeather(weather: currentTimeWeather, refreshLoading: false),
      ],
      verify: (bloc) {
        verify(mockWeatherRepository.fetchCurrentWeather()).called(1);
        verify(mockFlushbarHelper.showSuccess(message: Strings.dataUpToDate))
            .called(1);
      },
    );

    final obsoleteWeather = weather.copyWith(
        dateTime: DateTime.now().subtract(
            CurrentWeatherBloc.weatherFetchDelay + const Duration(seconds: 1)));

    blocTest<CurrentWeatherBloc, CurrentWeatherState>(
      'should fetch weather if previously fetched weather is obsolete',
      build: () {
        when(mockWeatherRepository.fetchCurrentWeather())
            .thenAnswer((_) => Future.value(obsoleteWeather));

        return bloc;
      },
      act: (bloc) async {
        bloc.add(const PageStarted());
        await untilCalled(mockWeatherRepository.fetchCurrentWeather());

        when(mockWeatherRepository.fetchCurrentWeather())
            .thenAnswer((_) => Future.value(currentTimeWeather));
        bloc.add(const RefreshPressed());
      },
      verify: (bloc) {
        verify(mockWeatherRepository.fetchCurrentWeather()).called(2);
      },
    );

    blocTest<CurrentWeatherBloc, CurrentWeatherState>(
      'should emit proper states when fetch current weather is gotten successfully',
      build: () {
        when(mockWeatherRepository.fetchCurrentWeather())
            .thenAnswer((_) => Future.value(obsoleteWeather));

        return bloc;
      },
      act: (bloc) async {
        bloc.add(const PageStarted());
        await untilCalled(mockWeatherRepository.fetchCurrentWeather());

        when(mockWeatherRepository.fetchCurrentWeather())
            .thenAnswer((_) => Future.value(currentTimeWeather));
        bloc.add(const RefreshPressed());
      },
      expect: <CurrentWeatherState>[
        const InitialLoading(),
        RenderWeather(weather: obsoleteWeather, refreshLoading: false),
        RenderWeather(weather: obsoleteWeather, refreshLoading: true),
        RenderWeather(weather: currentTimeWeather, refreshLoading: false),
      ],
    );

    blocTest<CurrentWeatherBloc, CurrentWeatherState>(
      'should emit proper states when fetch current weather fails',
      build: () {
        when(mockWeatherRepository.fetchCurrentWeather())
            .thenAnswer((_) => Future.value(weather));

        return bloc;
      },
      act: (bloc) async {
        bloc.add(const PageStarted());
        await untilCalled(mockWeatherRepository.fetchCurrentWeather());

        when(mockWeatherRepository.fetchCurrentWeather())
            .thenAnswer((_) => Future.error(const NoConnection()));
        bloc.add(const RefreshPressed());
      },
      expect: <CurrentWeatherState>[
        const InitialLoading(),
        RenderWeather(weather: weather, refreshLoading: false),
        RenderWeather(weather: weather, refreshLoading: true),
        RenderWeather(weather: weather, refreshLoading: false),
      ],
    );

    blocTest<CurrentWeatherBloc, CurrentWeatherState>(
      'should show error flushbar when fetch current weather fails',
      build: () {
        when(mockWeatherRepository.fetchCurrentWeather())
            .thenAnswer((_) => Future.value(weather));

        return bloc;
      },
      act: (bloc) async {
        bloc.add(const PageStarted());
        await untilCalled(mockWeatherRepository.fetchCurrentWeather());

        when(mockWeatherRepository.fetchCurrentWeather())
            .thenAnswer((_) => Future.error(const NoConnection()));
        bloc.add(const RefreshPressed());
      },
      verify: (bloc) {
        verify(mockFlushbarHelper.showError(
          message: Strings.apiErrorNoConnection,
        )).called(1);
      },
    );
  });

  group('on Retry Pressed event', () {
    blocTest<CurrentWeatherBloc, CurrentWeatherState>(
      'should emit proper states when fetch current weather is gotten successfully',
      build: () {
        when(mockWeatherRepository.fetchCurrentWeather())
            .thenAnswer((_) => Future.error(const NoConnection()));

        return bloc;
      },
      act: (bloc) async {
        bloc.add(const PageStarted());
        await untilCalled(mockWeatherRepository.fetchCurrentWeather());

        when(mockWeatherRepository.fetchCurrentWeather())
            .thenAnswer((_) => Future.value(weather));
        bloc.add(const RetryPressed());
      },
      expect: <CurrentWeatherState>[
        const InitialLoading(),
        const RenderError(message: Strings.fetchDataFailed, loading: false),
        const RenderError(message: Strings.fetchDataFailed, loading: true),
        RenderWeather(weather: weather, refreshLoading: false),
      ],
    );

    blocTest<CurrentWeatherBloc, CurrentWeatherState>(
      'should emit proper states when fetch current weather fails',
      build: () {
        when(mockWeatherRepository.fetchCurrentWeather())
            .thenAnswer((_) => Future.error(const NoConnection()));

        return bloc;
      },
      act: (bloc) async {
        bloc.add(const PageStarted());
        await untilCalled(mockWeatherRepository.fetchCurrentWeather());
        bloc.add(const RetryPressed());
      },
      expect: <CurrentWeatherState>[
        const InitialLoading(),
        const RenderError(message: Strings.fetchDataFailed, loading: false),
        const RenderError(message: Strings.fetchDataFailed, loading: true),
        const RenderError(message: Strings.fetchDataFailed, loading: false),
      ],
    );

    blocTest<CurrentWeatherBloc, CurrentWeatherState>(
      'should show error flushbar when fetch current weather fails',
      build: () {
        when(mockWeatherRepository.fetchCurrentWeather())
            .thenAnswer((_) => Future.error(const NoConnection()));

        return bloc;
      },
      act: (bloc) async {
        bloc.add(const PageStarted());
        await untilCalled(mockWeatherRepository.fetchCurrentWeather());
        bloc.add(const RetryPressed());
      },
      verify: (bloc) {
        verify(mockFlushbarHelper.showError(
                message: Strings.apiErrorNoConnection))
            .called(2);
      },
    );
  });
}
