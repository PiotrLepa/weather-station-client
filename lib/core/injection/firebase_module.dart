import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FirebaseModule {
  FirebaseMessaging get firebaseMessaging => FirebaseMessaging();
}
