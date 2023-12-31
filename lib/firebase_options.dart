// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
    apiKey: 'AIzaSyBOxZJ18fKHkT9GPddA2SE5Jf_82-FAdBk',
    appId: '1:640239067853:web:e1e6d2408eb26a2a42ff84',
    messagingSenderId: '640239067853',
    projectId: 'learning-app-9d22e',
    authDomain: 'learning-app-9d22e.firebaseapp.com',
    storageBucket: 'learning-app-9d22e.appspot.com',
    measurementId: 'G-K238G03JXQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC1nTZLEAvR6QxCsw22Eb7yxzIpjJoGcF8',
    appId: '1:640239067853:android:2d8c0f3dc96594e242ff84',
    messagingSenderId: '640239067853',
    projectId: 'learning-app-9d22e',
    storageBucket: 'learning-app-9d22e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBvd0Y2yiKU62OP7K0S9uoYfWEqOSjSBZM',
    appId: '1:640239067853:ios:dd6b6ca74f6b157a42ff84',
    messagingSenderId: '640239067853',
    projectId: 'learning-app-9d22e',
    storageBucket: 'learning-app-9d22e.appspot.com',
    iosBundleId: 'com.example.learningApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBvd0Y2yiKU62OP7K0S9uoYfWEqOSjSBZM',
    appId: '1:640239067853:ios:09548843b79a18a342ff84',
    messagingSenderId: '640239067853',
    projectId: 'learning-app-9d22e',
    storageBucket: 'learning-app-9d22e.appspot.com',
    iosBundleId: 'com.example.learningApp.RunnerTests',
  );
}
