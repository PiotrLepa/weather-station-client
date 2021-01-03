import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kt_dart/collection.dart';
import 'package:mockito/mockito.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_station/core/common/flushbar_helper.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/domain/bloc/configure_station/configure_station_bloc.dart';
import 'package:weather_station/domain/entity/signal_strength/signal_strength.dart';
import 'package:weather_station/domain/entity/wifi/wifi.dart';
import 'package:weather_station/domain/entity/wifi_encryption/wifi_encryption.dart';
import 'package:weather_station/domain/utils/station_configurator/station_configurator.dart';

import '../../utils/permissions_test_utils.dart';

class MockFlushbarHelper extends Mock implements FlushbarHelper {}

class MockStationConfigurator extends Mock implements StationConfigurator {}

final wifiList = KtList.of(
  const Wifi(
    name: 'Wifi_1',
    encryption: WifiEncryption.open(),
    signalStrength: SignalStrength.excellent(),
  ),
  const Wifi(
    name: 'Wifi_2',
    encryption: WifiEncryption.wpa2(),
    signalStrength: SignalStrength.fair(),
  ),
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
      'should emit render error state when permissions are permanently denied',
      build: () {
        mockPermissions({
          Permission.locationWhenInUse: PermissionStatus.permanentlyDenied,
        });

        return bloc;
      },
      act: (bloc) => bloc.add(const ScreenStarted()),
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
      build: () {
        mockPermissions({
          Permission.locationWhenInUse: PermissionStatus.granted,
        });

        when(mockStationConfigurator.getAvailableWifiList())
            .thenAnswer((realInvocation) => Future.value(wifiList));

        return bloc;
      },
      act: (bloc) => bloc.add(const ScreenStarted()),
      verify: (bloc) {
        verify(mockStationConfigurator.getAvailableWifiList()).called(1);
      },
      expect: <ConfigureStationState>[
        const Connecting(),
        RenderWifiList(wifiList),
      ],
    );
  });
}
