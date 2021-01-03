import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kt_dart/collection.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/domain/bloc/about_app/about_app_bloc.dart';
import 'package:weather_station/domain/entity/license/license.dart';
import 'package:weather_station/domain/utils/license/license_provider.dart';

class MockLicenseProvider extends Mock implements LicenseProvider {}

final iconsLicenses = KtList.of(
  const License(name: 'Icon_1'),
  const License(name: 'Icon_2'),
);

final packagesLicenses = KtList.of(
  const License(name: 'Package_1'),
  const License(name: 'Package_2'),
);

void main() {
  AboutAppBloc bloc;
  MockLicenseProvider mockLicenseProvider;

  setUpAll(() async {
    await configureInjection();
  });

  setUp(() {
    mockLicenseProvider = MockLicenseProvider();
    bloc = AboutAppBloc(mockLicenseProvider);
  });

  blocTest<AboutAppBloc, AboutAppState>(
    'initial state is RenderItems',
    build: () => bloc,
    verify: (bloc) => expect(bloc.state, const RenderItems()),
  );

  group('on IconsClicked event', () {
    blocTest<AboutAppBloc, AboutAppState>(
      'should push license list screen with proper args',
      build: () {
        when(mockLicenseProvider.getIconsLicenses())
            .thenAnswer((_) => Future.value(iconsLicenses));

        return bloc;
      },
      act: (bloc) => bloc.add(const IconsClicked()),
      verify: (bloc) {
        verify(mockLicenseProvider.getIconsLicenses()).called(1);
      },
      expect: <AboutAppState>[
        PushLicenseListScreen(
          title: Strings.aboutAppIconsItem,
          licenses: iconsLicenses,
        ),
      ],
    );
  });

  group('on PackagesClicked event', () {
    blocTest<AboutAppBloc, AboutAppState>(
      'should push license list screen with proper args',
      build: () {
        when(mockLicenseProvider.getPackagesLicenses())
            .thenAnswer((_) => Future.value(packagesLicenses));

        return bloc;
      },
      act: (bloc) => bloc.add(const PackagesClicked()),
      verify: (bloc) {
        verify(mockLicenseProvider.getPackagesLicenses()).called(1);
      },
      expect: <AboutAppState>[
        PushLicenseListScreen(
          title: Strings.aboutAppPackagesItem,
          licenses: packagesLicenses,
        ),
      ],
    );
  });
}
