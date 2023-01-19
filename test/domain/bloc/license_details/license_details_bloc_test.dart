// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:weather_station/core/injection/injection.dart';
// import 'package:weather_station/domain/bloc/license_details/license_details_bloc.dart';
//
// void main() {
//   late LicenseDetailsBloc bloc;
//
//   setUpAll(() async {
//     await configureInjection();
//   });
//
//   setUp(() {
//     bloc = LicenseDetailsBloc();
//   });
//
//   blocTest<LicenseDetailsBloc, LicenseDetailsState>(
//     'initial state is RenderPage',
//     build: () => bloc,
//     verify: (bloc) => expect(bloc.state, const RenderPage()),
//   );
// }
