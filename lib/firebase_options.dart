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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDhcnBjEsmPPKkhAyPlX5Qdhhj0GgattM8',
    appId: '1:176015174248:android:eb7f2a180c0d890a1e69dd',
    messagingSenderId: '176015174248',
    projectId: 'yahay-9f28f',
    storageBucket: 'yahay-9f28f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD5oQYkkpSx5O6PJbag8dMXIkBrV2T2-mA',
    appId: '1:176015174248:ios:ed44d234d3afba0a1e69dd',
    messagingSenderId: '176015174248',
    projectId: 'yahay-9f28f',
    storageBucket: 'yahay-9f28f.appspot.com',
    iosBundleId: 'com.example.yahay',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDhcnBjEsmPPKkhAyPlX5Qdhhj0GgattM8',
    authDomain: 'yahay-9f28f.firebaseapp.com',
    projectId: 'yahay-9f28f',
    storageBucket: 'yahay-9f28f.appspot.com',
    messagingSenderId: '176015174248',
    appId: '1:176015174248:web:someUniqueIdentifier', // replace with the actual web app ID
  );
}
