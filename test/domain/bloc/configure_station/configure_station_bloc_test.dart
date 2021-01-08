import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kt_dart/collection.dart';
import 'package:mockito/mockito.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_station/core/common/flushbar_helper.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/domain/bloc/configure_station/configure_station_bloc.dart';
import 'package:weather_station/domain/entity/connect_to_wifi_result/connect_to_wifi_result.dart';
import 'package:weather_station/domain/entity/signal_strength/signal_strength.dart';
import 'package:weather_station/domain/entity/wifi/wifi.dart';
import 'package:weather_station/domain/entity/wifi_credentials/wifi_credentials.dart';
import 'package:weather_station/domain/entity/wifi_encryption/wifi_encryption.dart';
import 'package:weather_station/domain/utils/station_configurator/station_configurator.dart';

import '../../utils/permissions_handler_utils.dart';

class MockFlushbarHelper extends Mock implements FlushbarHelper {}

class MockStationConfigurator extends Mock implements StationConfigurator {}

const openWifi = Wifi(
  name: 'Wifi_1',
  encryption: WifiEncryption.open(),
  signalStrength: SignalStrength.excellent(),
);

const securedWifi = Wifi(
  name: 'Wifi_2',
  encryption: WifiEncryption.wpa2(),
  signalStrength: SignalStrength.fair(),
);

const securedWifiCredentials = WifiCredentials(name: 'Wifi_2');

final wifiList = KtList.of(
  openWifi,
  securedWifi,
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  ConfigureStationBloc bloc;
  MockFlushbarHelper mockFlushbarHelper;
  MockStationConfigurator mockStationConfigurator;

  setUpAll(() async {
    await configureInjection();
  });

  setUp(() {
    mockFlushbarHelper = MockFlushbarHelper();
    mockStationConfigurator = MockStationConfigurator();
    bloc = ConfigureStationBloc(mockFlushbarHelper, mockStationConfigurator);
  });

  blocTest<ConfigureStationBloc, ConfigureStationState>(
    'initial state is Nothing',
    build: () => bloc,
    verify: (bloc) => expect(bloc.state, const Nothing()),
  );

  group('on ScreenStarted event', () {
    blocTest<ConfigureStationBloc, ConfigureStationState>(
      'should emit render error state show permission info dialog when permissions are permanently denied',
      build: () => bloc,
      act: (bloc) {
        mockPermissions({
          Permission.locationWhenInUse: PermissionStatus.permanentlyDenied,
        });

        bloc.add(const ScreenStarted());
      },
      expect: <ConfigureStationState>[
        const RenderError(
          message: Strings.connectToDevicePermissionError,
          loading: false,
        ),
        const ShowPermissionInfoDialog(),
        const Nothing(),
      ],
    );

    blocTest<ConfigureStationBloc, ConfigureStationState>(
      'should emit render wifi list if permissions are granted',
      build: () => bloc,
      act: (bloc) {
        mockPermissions({
          Permission.locationWhenInUse: PermissionStatus.granted,
        });
        when(mockStationConfigurator.getAvailableWifiList())
            .thenAnswer((_) async => wifiList);

        bloc.add(const ScreenStarted());
      },
      verify: (bloc) {
        verify(mockStationConfigurator.getAvailableWifiList()).called(1);
      },
      expect: <ConfigureStationState>[
        const Connecting(),
        RenderWifiList(wifiList),
      ],
    );
  });

  group('on RetryClicked event', () {
    blocTest<ConfigureStationBloc, ConfigureStationState>(
      'should emit render error state show permission info dialog when permissions are permanently denied',
      build: () => bloc,
      act: (bloc) {
        mockPermissions({
          Permission.locationWhenInUse: PermissionStatus.permanentlyDenied,
        });

        bloc.add(const RetryClicked());
      },
      expect: <ConfigureStationState>[
        const ShowPermissionInfoDialog(),
        const Nothing(),
      ],
    );

    blocTest<ConfigureStationBloc, ConfigureStationState>(
      'should emit render wifi list if permissions are granted',
      build: () => bloc,
      act: (bloc) {
        mockPermissions({
          Permission.locationWhenInUse: PermissionStatus.granted,
        });
        when(mockStationConfigurator.getAvailableWifiList())
            .thenAnswer((_) async => wifiList);

        bloc.add(const RetryClicked());
      },
      verify: (bloc) {
        verify(mockStationConfigurator.getAvailableWifiList()).called(1);
      },
      expect: <ConfigureStationState>[
        const Connecting(),
        RenderWifiList(wifiList),
      ],
    );
  });

  group('on WifiSelected event', () {
    blocTest<ConfigureStationBloc, ConfigureStationState>(
      'should emit proper connecting dialog states',
      build: () => bloc,
      act: (bloc) {
        when(mockStationConfigurator.sendWifiCredentials(any))
            .thenAnswer((_) async => const ConnectToWifiResult.connected());

        bloc.add(const WifiSelected(openWifi));
      },
      expect: <ConfigureStationState>[
        const ShowConnectingToWifiDialog(),
        const Nothing(),
        const Pop(),
      ],
    );

    blocTest<ConfigureStationBloc, ConfigureStationState>(
      'should show success flushbar if wifi is open and connected successfully',
      build: () => bloc,
      act: (bloc) {
        when(mockStationConfigurator.sendWifiCredentials(any))
            .thenAnswer((_) async => const ConnectToWifiResult.connected());

        bloc.add(const WifiSelected(openWifi));
      },
      verify: (bloc) {
        verify(mockFlushbarHelper.showSuccess(
          message: Strings.connectStationToWifiSuccess,
        )).called(1);
      },
    );

    blocTest<ConfigureStationBloc, ConfigureStationState>(
      'should show error flushbar if wifi is open and failed to connect ',
      build: () => bloc,
      act: (bloc) {
        when(mockStationConfigurator.sendWifiCredentials(any))
            .thenAnswer((_) async => const ConnectToWifiResult.error());

        bloc.add(const WifiSelected(openWifi));
      },
      verify: (bloc) {
        verify(mockFlushbarHelper.showError(
          message: Strings.connectStationToWifiError,
        )).called(1);
      },
    );

    blocTest<ConfigureStationBloc, ConfigureStationState>(
      'should show wifi password input dialog if wifi is secured',
      build: () => bloc,
      act: (bloc) => bloc.add(const WifiSelected(securedWifi)),
      expect: <ConfigureStationState>[
        const ShowWifiPasswordInputDialog(securedWifi),
        const Nothing(),
      ],
    );
  });

  group('on PasswordInserted event', () {
    blocTest<ConfigureStationBloc, ConfigureStationState>(
      'should show success flushbar if wifi is secured and connected successfully',
      build: () => bloc,
      act: (bloc) {
        when(mockStationConfigurator.sendWifiCredentials(any))
            .thenAnswer((_) async => const ConnectToWifiResult.connected());

        bloc.add(const PasswordInserted(securedWifiCredentials));
      },
      verify: (bloc) {
        verify(mockFlushbarHelper.showSuccess(
          message: Strings.connectStationToWifiSuccess,
        )).called(1);
      },
    );

    blocTest<ConfigureStationBloc, ConfigureStationState>(
      'should show error flushbar if wifi is secured and failed to connect ',
      build: () => bloc,
      act: (bloc) {
        when(mockStationConfigurator.sendWifiCredentials(any))
            .thenAnswer((_) async => const ConnectToWifiResult.error());

        bloc.add(const PasswordInserted(securedWifiCredentials));
      },
      verify: (bloc) {
        verify(mockFlushbarHelper.showError(
          message: Strings.connectStationToWifiError,
        )).called(1);
      },
    );
  });
}
