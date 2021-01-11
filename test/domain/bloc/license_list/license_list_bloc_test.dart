import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/domain/bloc/license_list/license_list_bloc.dart';
import 'package:weather_station/domain/entity/license/license.dart';

const license = License(
  name: 'License_1',
  details: 'details',
);

const licenseWithoutDetails = License(
  name: 'License_2',
);

void main() {
  LicenseListBloc bloc;

  setUpAll(() async {
    await configureInjection();
  });

  setUp(() {
    bloc = LicenseListBloc();
  });

  blocTest<LicenseListBloc, LicenseListState>(
    'initial state is RenderItems',
    build: () => bloc,
    verify: (bloc) => expect(bloc.state, const RenderItems()),
  );

  group('on LicenseClicked event', () {
    blocTest<LicenseListBloc, LicenseListState>(
      'should push details screen if license has details',
      build: () => bloc,
      act: (bloc) => bloc.add(const LicenseClicked(license)),
      expect: <LicenseListState>[
        const LicenseListState.pushLicenseDetails(license: license),
      ],
    );

    blocTest<LicenseListBloc, LicenseListState>(
      'should do nothing if license does not have details',
      build: () => bloc,
      act: (bloc) => bloc.add(const LicenseClicked(licenseWithoutDetails)),
      expect: <LicenseListState>[],
    );
  });
}
