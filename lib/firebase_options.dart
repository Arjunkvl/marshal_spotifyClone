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
    apiKey: 'AIzaSyDnv49jzVYP-SAklI9O3YFn_F3hL9Hqedg',
    appId: '1:440138373386:web:f26345999e0c70fdef02f3',
    messagingSenderId: '440138373386',
    projectId: 'marshal-33e85',
    authDomain: 'marshal-33e85.firebaseapp.com',
    storageBucket: 'marshal-33e85.appspot.com',
    measurementId: 'G-DT0BD3YFTK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBppF0iYkwh3VdToHwIGdyTLp6B0R0JoGM',
    appId: '1:440138373386:android:5ba802fcb5b323a1ef02f3',
    messagingSenderId: '440138373386',
    projectId: 'marshal-33e85',
    storageBucket: 'marshal-33e85.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyASXab3eXBJTcGvzcN8HIWwhi5etLabjxI',
    appId: '1:440138373386:ios:6f370fc713cd041aef02f3',
    messagingSenderId: '440138373386',
    projectId: 'marshal-33e85',
    storageBucket: 'marshal-33e85.appspot.com',
    iosBundleId: 'com.example.marshal',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyASXab3eXBJTcGvzcN8HIWwhi5etLabjxI',
    appId: '1:440138373386:ios:ef8ee61c16100913ef02f3',
    messagingSenderId: '440138373386',
    projectId: 'marshal-33e85',
    storageBucket: 'marshal-33e85.appspot.com',
    iosBundleId: 'com.example.marshal.RunnerTests',
  );
}