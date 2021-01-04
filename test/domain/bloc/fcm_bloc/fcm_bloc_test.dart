import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_station/core/common/flushbar_helper.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/domain/bloc/fcm_bloc/fcm_bloc.dart';
import 'package:weather_station/domain/entity/notification/notification.dart';
import 'package:weather_station/domain/repository/fcm_repository.dart';

class MockFcmRepository extends Mock implements FcmRepository {}

class MockFlushbarHelper extends Mock implements FlushbarHelper {}

const notification = Notification(title: 'Title', body: 'Body');

void main() {
  FcmBloc bloc;
  MockFcmRepository mockFcmRepository;
  MockFlushbarHelper mockFlushbarHelper;

  setUpAll(() async {
    await configureInjection();
  });

  setUp(() {
    mockFcmRepository = MockFcmRepository();
    mockFlushbarHelper = MockFlushbarHelper();
    bloc = FcmBloc(mockFcmRepository, mockFlushbarHelper);
  });

  blocTest<FcmBloc, FcmState>(
    'initial state is Nothing',
    build: () => bloc,
    verify: (bloc) => expect(bloc.state, const Nothing()),
  );

  group('on Created event', () {
    blocTest<FcmBloc, FcmState>(
      'should show notification when received',
      build: () => bloc,
      act: (bloc) {
        when(mockFcmRepository.getRainDetected())
            .thenAnswer((_) => Stream.value(notification));

        bloc.add(const Created());
      },
      verify: (bloc) {
        verify(
          mockFlushbarHelper.showNotification(
            message: anyNamed('message'),
          ),
        ).called(1);
      },
    );
  });
}
