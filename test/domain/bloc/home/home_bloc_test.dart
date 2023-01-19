// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:weather_station/core/injection/injection.dart';
// import 'package:weather_station/domain/bloc/home/home_bloc.dart';
//
// void main() {
//   late HomeBloc bloc;
//
//   setUpAll(() async {
//     await configureInjection();
//   });
//
//   setUp(() {
//     bloc = HomeBloc();
//   });
//
//   blocTest<HomeBloc, HomeState>(
//     'initial state is ChangePage',
//     build: () => bloc,
//     verify: (bloc) => expect(bloc.state, const ChangePage(0)),
//   );
//
//   group('on BottomNavigationClicked event', () {
//     blocTest<HomeBloc, HomeState>('should emit state for change page',
//         build: () => bloc,
//         act: (bloc) => bloc.add(const BottomNavigationClicked(3)),
//         expect: () => <HomeState>[
//               const ChangePage(3),
//             ]);
//   });
// }
