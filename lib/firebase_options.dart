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
    apiKey: 'AIzaSyAMq6yED7kSYADkyPgcs2EpHy-8YAS9YcE',
    appId: '1:849984198070:web:3f74b5fb8c7ccd0adfdd17',
    messagingSenderId: '849984198070',
    projectId: 'flutter-ojt-33f6c',
    authDomain: 'flutter-ojt-33f6c.firebaseapp.com',
    storageBucket: 'flutter-ojt-33f6c.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAhFrcCtDU947gA2WgmPhB2-rC377PNW_s',
    appId: '1:849984198070:android:c6508a817769b3a7dfdd17',
    messagingSenderId: '849984198070',
    projectId: 'flutter-ojt-33f6c',
    storageBucket: 'flutter-ojt-33f6c.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAbMyJfxKAqp99VpO0uUFsLO4v6Y26QU8w',
    appId: '1:849984198070:ios:22d628ca3bca13bddfdd17',
    messagingSenderId: '849984198070',
    projectId: 'flutter-ojt-33f6c',
    storageBucket: 'flutter-ojt-33f6c.firebasestorage.app',
    iosBundleId: 'com.example.ojtProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAbMyJfxKAqp99VpO0uUFsLO4v6Y26QU8w',
    appId: '1:849984198070:ios:22d628ca3bca13bddfdd17',
    messagingSenderId: '849984198070',
    projectId: 'flutter-ojt-33f6c',
    storageBucket: 'flutter-ojt-33f6c.firebasestorage.app',
    iosBundleId: 'com.example.ojtProject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAMq6yED7kSYADkyPgcs2EpHy-8YAS9YcE',
    appId: '1:849984198070:web:f91e8983ae41c7d4dfdd17',
    messagingSenderId: '849984198070',
    projectId: 'flutter-ojt-33f6c',
    authDomain: 'flutter-ojt-33f6c.firebaseapp.com',
    storageBucket: 'flutter-ojt-33f6c.firebasestorage.app',
  );

}