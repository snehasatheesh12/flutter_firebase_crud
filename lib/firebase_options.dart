// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyBsCd2Hh5a66DYB8Unnnw7c1C1tLPblsdc',
    appId: '1:660327518426:web:97f49f37b75d0a981415e3',
    messagingSenderId: '660327518426',
    projectId: 'flutter-20a71',
    authDomain: 'flutter-20a71.firebaseapp.com',
    storageBucket: 'flutter-20a71.appspot.com',
    measurementId: 'G-Q0S5S3Q7ZV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA7Qh8C9PPRzTmTxfxLhVyMiUrgW0C24DQ',
    appId: '1:660327518426:android:4596a11d39e707761415e3',
    messagingSenderId: '660327518426',
    projectId: 'flutter-20a71',
    storageBucket: 'flutter-20a71.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBAKVNz_jkmwgXf-jl6CuweZsxEh5ErShw',
    appId: '1:660327518426:ios:584269b3eae926731415e3',
    messagingSenderId: '660327518426',
    projectId: 'flutter-20a71',
    storageBucket: 'flutter-20a71.appspot.com',
    iosBundleId: 'com.example.crud',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBAKVNz_jkmwgXf-jl6CuweZsxEh5ErShw',
    appId: '1:660327518426:ios:584269b3eae926731415e3',
    messagingSenderId: '660327518426',
    projectId: 'flutter-20a71',
    storageBucket: 'flutter-20a71.appspot.com',
    iosBundleId: 'com.example.crud',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBsCd2Hh5a66DYB8Unnnw7c1C1tLPblsdc',
    appId: '1:660327518426:web:1448bea831d3e3861415e3',
    messagingSenderId: '660327518426',
    projectId: 'flutter-20a71',
    authDomain: 'flutter-20a71.firebaseapp.com',
    storageBucket: 'flutter-20a71.appspot.com',
    measurementId: 'G-70D237BTSN',
  );
}
