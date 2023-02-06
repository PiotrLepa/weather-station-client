// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC4_cLrGfmHWEDLOA82y16L4xtNdj6mETw',
    appId: '1:608229954934:web:4982fa0f4766e38e771657',
    messagingSenderId: '608229954934',
    projectId: 'weather-station-2bb34',
    authDomain: 'weather-station-2bb34.firebaseapp.com',
    storageBucket: 'weather-station-2bb34.appspot.com',
    measurementId: 'G-MF7E6JZX0Q',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBfh8XMyHibIUrr5WigAmaSqYuLPcoGdo4',
    appId: '1:608229954934:android:f8be46433c793008771657',
    messagingSenderId: '608229954934',
    projectId: 'weather-station-2bb34',
    storageBucket: 'weather-station-2bb34.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB34uCkHjLf_7oRKKr_plZtvjBlR5hv19c',
    appId: '1:608229954934:ios:b30e1b6e908f4354771657',
    messagingSenderId: '608229954934',
    projectId: 'weather-station-2bb34',
    storageBucket: 'weather-station-2bb34.appspot.com',
    iosClientId:
        '608229954934-9j835847n3f425llqaiqffnda5u2n184.apps.googleusercontent.com',
    iosBundleId: 'com.example.weatherStationClient',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB34uCkHjLf_7oRKKr_plZtvjBlR5hv19c',
    appId: '1:608229954934:ios:b30e1b6e908f4354771657',
    messagingSenderId: '608229954934',
    projectId: 'weather-station-2bb34',
    storageBucket: 'weather-station-2bb34.appspot.com',
    iosClientId:
        '608229954934-9j835847n3f425llqaiqffnda5u2n184.apps.googleusercontent.com',
    iosBundleId: 'com.example.weatherStationClient',
  );
}
