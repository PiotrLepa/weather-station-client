// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:kt_dart/collection.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:weather_station/core/common/flushbar_helper.dart';
// import 'package:weather_station/core/data/network/exception/api/api_exception.dart';
// import 'package:weather_station/core/injection/injection.dart';
// import 'package:weather_station/core/presentation/language/strings.al.dart';
// import 'package:weather_station/domain/bloc/hourly_weather/hourly_weather_bloc.dart';
// import 'package:weather_station/domain/entity/available_days/available_days.dart';
// import 'package:weather_station/domain/entity/hourly_weather/hourly_weather.dart';
// import 'package:weather_station/domain/repository/weather_repository.dart';
//
// import 'hourly_weather_bloc_test.mocks.dart';
//
// final availableDays = AvailableDays(
//   days: KtList.of(
//     DateTime(2020, 5, 10),
//     DateTime(2020, 6, 12),
//     DateTime(2020, 6, 16),
//     DateTime(2020, 8, 8),
//   ),
// );
//
// final selectedDay = availableDays.days.first();
//
// final selectedDay2 = availableDays.days[2];
//
// final hourlyWeathers = KtList.of(
//   HourlyWeather(
//     temperature: 22.2,
//     humidity: 65.7,
//     pressure: 989,
//     pm1: 24,
//     pm25: 27,
//     pm10: 22,
//     windSpeedMax: 12.2,
//     windSpeedAvg: 5.3,
//     rainGauge: 0.0,
//     dateTime: DateTime(selectedDay.year, selectedDay.month, selectedDay.day),
//   ),
//   HourlyWeather(
//     temperature: 23.2,
//     humidity: 62.7,
//     pressure: 989,
//     pm1: 22,
//     pm25: 23,
//     pm10: 21,
//     windSpeedMax: 9.4,
//     windSpeedAvg: 3.3,
//     rainGauge: 0.0,
//     dateTime: DateTime(selectedDay.year, selectedDay.month, selectedDay.day, 1),
//   ),
// );
//
// final hourlyWeathers2 = KtList.of(
//   HourlyWeather(
//     temperature: 23.2,
//     humidity: 62.7,
//     pressure: 988,
//     pm1: 14,
//     pm25: 17,
//     pm10: 12,
//     windSpeedMax: 14.1,
//     windSpeedAvg: 7.3,
//     rainGauge: 4.3,
//     dateTime: DateTime(selectedDay2.year, selectedDay2.month, selectedDay2.day),
//   ),
//   HourlyWeather(
//     temperature: 23.2,
//     humidity: 62.7,
//     pressure: 988,
//     pm1: 12,
//     pm25: 13,
//     pm10: 11,
//     windSpeedMax: 8.2,
//     windSpeedAvg: 4.7,
//     rainGauge: 5.2,
//     dateTime:
//         DateTime(selectedDay2.year, selectedDay2.month, selectedDay2.day, 1),
//   ),
// );
//
// @GenerateMocks([FlushbarHelper, WeatherRepository])
// void main() {
//   late HourlyWeatherBloc bloc;
//   late MockWeatherRepository mockWeatherRepository;
//   late MockFlushbarHelper mockFlushbarHelper;
//
//   setUpAll(() async {
//     await configureInjection();
//   });
//
//   setUp(() {
//     mockWeatherRepository = MockWeatherRepository();
//     mockFlushbarHelper = MockFlushbarHelper();
//     bloc = HourlyWeatherBloc(mockWeatherRepository, mockFlushbarHelper);
//   });
//
//   blocTest<HourlyWeatherBloc, HourlyWeatherState>(
//     'initial state is InitialLoading',
//     build: () => bloc,
//     verify: (bloc) => expect(bloc.state, const InitialLoading()),
//   );
//
//   group('on ScreenStarted event', () {
//     blocTest<HourlyWeatherBloc, HourlyWeatherState>(
//       'should emit proper states if days are gotten successfully',
//       build: () => bloc,
//       act: (bloc) {
//         when(mockWeatherRepository.fetchAvailableDays())
//             .thenAnswer((_) async => availableDays);
//
//         bloc.add(const ScreenStarted());
//       },
//       expect: () => <HourlyWeatherState>[
//         const InitialLoading(),
//         RenderSelectDate(
//           selectDateLoading: false,
//           availableDays: availableDays.days,
//         ),
//       ],
//     );
//
//     blocTest<HourlyWeatherBloc, HourlyWeatherState>(
//       'should emit proper states if fetch available days fails',
//       build: () => bloc,
//       act: (bloc) {
//         when(mockWeatherRepository.fetchAvailableDays())
//             .thenAnswer((_) => Future.error(const NoConnection()));
//
//         bloc.add(const ScreenStarted());
//       },
//       expect: () => <HourlyWeatherState>[
//         const InitialLoading(),
//         const RenderError(message: Strings.fetchDataFailed, loading: false),
//       ],
//     );
//   });
//
//   group('on RetryPressed event', () {
//     blocTest<HourlyWeatherBloc, HourlyWeatherState>(
//       'should emit proper states if days are gotten successfully',
//       build: () => bloc,
//       act: (bloc) async {
//         when(mockWeatherRepository.fetchAvailableDays())
//             .thenAnswer((_) => Future.error(const NoConnection()));
//
//         bloc.add(const ScreenStarted());
//
//         await untilCalled(mockWeatherRepository.fetchAvailableDays());
//
//         when(mockWeatherRepository.fetchAvailableDays())
//             .thenAnswer((_) async => availableDays);
//
//         bloc.add(const RetryPressed());
//       },
//       skip: 2,
//       expect: () => <HourlyWeatherState>[
//         const RenderError(message: Strings.fetchDataFailed, loading: true),
//         RenderSelectDate(
//           selectDateLoading: false,
//           availableDays: availableDays.days,
//         ),
//       ],
//     );
//
//     blocTest<HourlyWeatherBloc, HourlyWeatherState>(
//       'should emit proper states if fetch available days fails',
//       build: () => bloc,
//       act: (bloc) async {
//         when(mockWeatherRepository.fetchAvailableDays())
//             .thenAnswer((_) => Future.error(const NoConnection()));
//
//         bloc.add(const ScreenStarted());
//
//         await untilCalled(mockWeatherRepository.fetchAvailableDays());
//
//         bloc.add(const RetryPressed());
//       },
//       skip: 2,
//       expect: () => <HourlyWeatherState>[
//         const RenderError(message: Strings.fetchDataFailed, loading: true),
//         const RenderError(message: Strings.fetchDataFailed, loading: false),
//       ],
//     );
//
//     blocTest<HourlyWeatherBloc, HourlyWeatherState>(
//       'should emit proper states if fetch hourly weathers fails',
//       build: () => bloc,
//       act: (bloc) async {
//         when(mockWeatherRepository.fetchAvailableDays())
//             .thenAnswer((_) => Future.error(const NoConnection()));
//
//         bloc.add(const ScreenStarted());
//
//         await untilCalled(mockWeatherRepository.fetchAvailableDays());
//
//         bloc.add(const RetryPressed());
//       },
//       verify: (bloc) {
//         verify(mockFlushbarHelper.showError(
//             message: Strings.apiErrorNoConnection))
//             .called(1);
//       },
//     );
//   });
//
//   group('on LoadPressed event', () {
//     blocTest<HourlyWeatherBloc, HourlyWeatherState>(
//       'should emit proper states if hourly weathers are gotten successfully',
//       build: () => bloc,
//       act: (bloc) async {
//         when(mockWeatherRepository.fetchAvailableDays())
//             .thenAnswer((_) async => availableDays);
//         when(mockWeatherRepository.fetchHourlyWeather(selectedDay))
//             .thenAnswer((_) async => hourlyWeathers);
//
//         bloc.add(const ScreenStarted());
//
//         await untilCalled(mockWeatherRepository.fetchAvailableDays());
//
//         bloc.add(LoadPressed(selectedDay));
//       },
//       skip: 2,
//       expect: () => <HourlyWeatherState>[
//         RenderSelectDate(
//           selectDateLoading: true,
//           availableDays: availableDays.days,
//         ),
//         RenderCharts(
//           weathers: hourlyWeathers,
//           changeDateLoading: false,
//           availableDays: availableDays.days,
//         ),
//       ],
//     );
//
//     blocTest<HourlyWeatherBloc, HourlyWeatherState>(
//       'should emit proper states if fetch hourly weathers fails',
//       build: () => bloc,
//       act: (bloc) async {
//         when(mockWeatherRepository.fetchAvailableDays())
//             .thenAnswer((_) async => availableDays);
//         when(mockWeatherRepository.fetchHourlyWeather(selectedDay))
//             .thenAnswer((_) => Future.error(const NoConnection()));
//
//         bloc.add(const ScreenStarted());
//
//         await untilCalled(mockWeatherRepository.fetchAvailableDays());
//
//         bloc.add(LoadPressed(selectedDay));
//       },
//       skip: 2,
//       expect: () => <HourlyWeatherState>[
//         RenderSelectDate(
//           selectDateLoading: true,
//           availableDays: availableDays.days,
//         ),
//         RenderSelectDate(
//           selectDateLoading: false,
//           availableDays: availableDays.days,
//         ),
//       ],
//     );
//
//     blocTest<HourlyWeatherBloc, HourlyWeatherState>(
//       'should emit proper states if fetch hourly weathers fails',
//       build: () => bloc,
//       act: (bloc) async {
//         when(mockWeatherRepository.fetchAvailableDays())
//             .thenAnswer((_) async => availableDays);
//         when(mockWeatherRepository.fetchHourlyWeather(selectedDay))
//             .thenAnswer((_) => Future.error(const NoConnection()));
//
//         bloc.add(const ScreenStarted());
//
//         await untilCalled(mockWeatherRepository.fetchAvailableDays());
//
//         bloc.add(LoadPressed(selectedDay));
//       },
//       verify: (bloc) {
//         verify(mockFlushbarHelper.showError(
//             message: Strings.apiErrorNoConnection))
//             .called(1);
//       },
//     );
//   });
//
//   group('on ChangeDatePressed event', () {
//     blocTest<HourlyWeatherBloc, HourlyWeatherState>(
//       'should not fetch hourly weathers if selected day is the same as previous one',
//       build: () => bloc,
//       act: (bloc) async {
//         when(mockWeatherRepository.fetchAvailableDays())
//             .thenAnswer((_) async => availableDays);
//         when(mockWeatherRepository.fetchHourlyWeather(selectedDay))
//             .thenAnswer((_) async => hourlyWeathers);
//
//         bloc.add(const ScreenStarted());
//
//         await untilCalled(mockWeatherRepository.fetchAvailableDays());
//
//         bloc.add(LoadPressed(selectedDay));
//
//         await untilCalled(
//             mockWeatherRepository.fetchHourlyWeather(selectedDay));
//
//         bloc.add(ChangeDatePressed(selectedDay));
//       },
//       verify: (bloc) async {
//         verify(mockWeatherRepository.fetchAvailableDays());
//         verify(mockWeatherRepository.fetchHourlyWeather(selectedDay));
//         verifyNoMoreInteractions(mockFlushbarHelper);
//         verifyNoMoreInteractions(mockWeatherRepository);
//       },
//     );
//
//     blocTest<HourlyWeatherBloc, HourlyWeatherState>(
//       'should emit proper states if hourly weathers are gotten successfully',
//       build: () => bloc,
//       act: (bloc) async {
//         when(mockWeatherRepository.fetchAvailableDays())
//             .thenAnswer((_) async => availableDays);
//         when(mockWeatherRepository.fetchHourlyWeather(selectedDay))
//             .thenAnswer((_) async => hourlyWeathers);
//
//         bloc.add(const ScreenStarted());
//
//         await untilCalled(mockWeatherRepository.fetchAvailableDays());
//
//         bloc.add(LoadPressed(selectedDay));
//
//         await untilCalled(
//             mockWeatherRepository.fetchHourlyWeather(selectedDay));
//
//         when(mockWeatherRepository.fetchHourlyWeather(selectedDay2))
//             .thenAnswer((_) async => hourlyWeathers2);
//
//         bloc.add(ChangeDatePressed(selectedDay2));
//       },
//       skip: 4,
//       expect: () => <HourlyWeatherState>[
//         RenderCharts(
//           weathers: hourlyWeathers,
//           changeDateLoading: true,
//           availableDays: availableDays.days,
//         ),
//         RenderCharts(
//           weathers: hourlyWeathers2,
//           changeDateLoading: false,
//           availableDays: availableDays.days,
//         ),
//       ],
//     );
//
//     blocTest<HourlyWeatherBloc, HourlyWeatherState>(
//       'should emit proper states if fetch hourly weathers fails',
//       build: () => bloc,
//       act: (bloc) async {
//         when(mockWeatherRepository.fetchAvailableDays())
//             .thenAnswer((_) async => availableDays);
//         when(mockWeatherRepository.fetchHourlyWeather(selectedDay))
//             .thenAnswer((_) async => hourlyWeathers);
//
//         bloc.add(const ScreenStarted());
//
//         await untilCalled(mockWeatherRepository.fetchAvailableDays());
//
//         bloc.add(LoadPressed(selectedDay));
//
//         await untilCalled(
//             mockWeatherRepository.fetchHourlyWeather(selectedDay));
//
//         when(mockWeatherRepository.fetchHourlyWeather(selectedDay2))
//             .thenAnswer((_) => Future.error(const NoConnection()));
//
//         bloc.add(ChangeDatePressed(selectedDay2));
//       },
//       skip: 4,
//       expect: () => <HourlyWeatherState>[
//         RenderCharts(
//           weathers: hourlyWeathers,
//           changeDateLoading: true,
//           availableDays: availableDays.days,
//         ),
//         RenderCharts(
//           weathers: hourlyWeathers,
//           changeDateLoading: false,
//           availableDays: availableDays.days,
//         ),
//       ],
//     );
//
//     blocTest<HourlyWeatherBloc, HourlyWeatherState>(
//       'should show error flushbar if fetch hourly weathers fails',
//       build: () => bloc,
//       act: (bloc) async {
//         when(mockWeatherRepository.fetchAvailableDays())
//             .thenAnswer((_) async => availableDays);
//         when(mockWeatherRepository.fetchHourlyWeather(selectedDay))
//             .thenAnswer((_) async => hourlyWeathers);
//
//         bloc.add(const ScreenStarted());
//
//         await untilCalled(mockWeatherRepository.fetchAvailableDays());
//
//         bloc.add(LoadPressed(selectedDay));
//
//         await untilCalled(
//             mockWeatherRepository.fetchHourlyWeather(selectedDay));
//
//         when(mockWeatherRepository.fetchHourlyWeather(selectedDay2))
//             .thenAnswer((_) => Future.error(const NoConnection()));
//
//         bloc.add(ChangeDatePressed(selectedDay2));
//       },
//       verify: (bloc) {
//         verify(mockFlushbarHelper.showError(
//             message: Strings.apiErrorNoConnection))
//             .called(1);
//       },
//     );
//   });
// }
