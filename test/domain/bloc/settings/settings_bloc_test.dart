import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_station/core/common/flushbar_helper.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/domain/bloc/settings/settings_bloc.dart';
import 'package:weather_station/domain/utils/notification/notification_subscriber.dart';

import 'settings_bloc_test.mocks.dart';

@GenerateMocks([FlushbarHelper, NotificationSubscriber])
void main() {
  late SettingsBloc bloc;
  late MockNotificationSubscriber mockNotificationSubscriber;
  late MockFlushbarHelper mockFlushbarHelper;

  setUpAll(() async {
    await configureInjection();
  });

  setUp(() {
    mockNotificationSubscriber = MockNotificationSubscriber();
    mockFlushbarHelper = MockFlushbarHelper();
    bloc = SettingsBloc(mockNotificationSubscriber, mockFlushbarHelper);
  });

  blocTest<SettingsBloc, SettingsState>(
    'initial state is Loading',
    build: () => bloc,
    verify: (bloc) => expect(bloc.state, const Loading()),
  );

  group('on PageStarted event', () {
    blocTest<SettingsBloc, SettingsState>(
      'should emit proper states',
      build: () => bloc,
      act: (bloc) {
        when(mockNotificationSubscriber.arePushEnabled)
            .thenAnswer((realInvocation) async => true);

        bloc.add(const PageStarted());
      },
      expect: () => <SettingsState>[
        const RenderItems(pushEnabled: true),
      ],
    );
  });

  group('on ConfigureWifiClicked event', () {
    blocTest<SettingsBloc, SettingsState>(
      'should push configure station screen',
      build: () => bloc,
      act: (bloc) => bloc.add(const ConfigureWifiClicked()),
      expect: () => <SettingsState>[
        const PushConfigureStationScreen(),
        const Nothing(),
      ],
    );
  });

  group('on AboutAppClicked event', () {
    blocTest<SettingsBloc, SettingsState>(
      'should push about app screen',
      build: () => bloc,
      act: (bloc) => bloc.add(const AboutAppClicked()),
      expect: () => <SettingsState>[
        const PushAboutAppScreen(),
        const Nothing(),
      ],
    );
  });
}
