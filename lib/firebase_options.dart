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
    apiKey: 'AIzaSyC719Waa_TxY6xPi0PE41YOLb2DVMQ6uyI',
    appId: '1:279233651444:web:176fbc76624122062ff4a1',
    messagingSenderId: '279233651444',
    projectId: 'ny-app-firebase',
    authDomain: 'ny-app-firebase.firebaseapp.com',
    storageBucket: 'ny-app-firebase.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDNRvx6PA2rLMkdzo-NrkNxU1JQJ5vkSW8',
    appId: '1:279233651444:android:fbd023b7f6b4ecad2ff4a1',
    messagingSenderId: '279233651444',
    projectId: 'ny-app-firebase',
    storageBucket: 'ny-app-firebase.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBOWt6PwGFeAE9qm4avFsPAH2HiZd4udqA',
    appId: '1:279233651444:ios:8333c01731da9e942ff4a1',
    messagingSenderId: '279233651444',
    projectId: 'ny-app-firebase',
    storageBucket: 'ny-app-firebase.appspot.com',
    iosBundleId: 'com.example.myApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBOWt6PwGFeAE9qm4avFsPAH2HiZd4udqA',
    appId: '1:279233651444:ios:60587c82a4f5bee12ff4a1',
    messagingSenderId: '279233651444',
    projectId: 'ny-app-firebase',
    storageBucket: 'ny-app-firebase.appspot.com',
    iosBundleId: 'com.example.myApp.RunnerTests',
  );
}