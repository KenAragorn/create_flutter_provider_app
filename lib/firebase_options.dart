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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDZzjbyy_AnyqtffENSy8k5Az5Jj46T5eU',
    appId: '1:395840317251:web:4cc107d1d6b59033f571f6',
    messagingSenderId: '395840317251',
    projectId: 'create-flutter-provider-b6213',
    authDomain: 'create-flutter-provider-b6213.firebaseapp.com',
    storageBucket: 'create-flutter-provider-b6213.appspot.com',
    measurementId: 'G-NKX952QRCM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC36HyNn7EnFhNGNQW3pTpB4_-7Pb-aSkY',
    appId: '1:395840317251:android:74c37af1177ecbf3f571f6',
    messagingSenderId: '395840317251',
    projectId: 'create-flutter-provider-b6213',
    storageBucket: 'create-flutter-provider-b6213.appspot.com',
  );
}
