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
    apiKey: 'AIzaSyCj9thDg5HsiJhSi4ROJwCiivGFixEaj6I',
    appId: '1:646096833745:web:8cb27bc727474f28e8c9f0',
    messagingSenderId: '646096833745',
    projectId: 'vera-life-clinic',
    authDomain: 'vera-life-clinic.firebaseapp.com',
    storageBucket: 'vera-life-clinic.firebasestorage.app',
    measurementId: 'G-MMC6Z6LE1C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAEG3g-CkdkHUB7Ki3AVS0_N7TEG-5dR9Y',
    appId: '1:646096833745:android:c14056839c803e04e8c9f0',
    messagingSenderId: '646096833745',
    projectId: 'vera-life-clinic',
    storageBucket: 'vera-life-clinic.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAylxMOyLt_EakbK4PY81040bIE5fXpGXg',
    appId: '1:646096833745:ios:6882747f9a94eb59e8c9f0',
    messagingSenderId: '646096833745',
    projectId: 'vera-life-clinic',
    storageBucket: 'vera-life-clinic.firebasestorage.app',
    iosBundleId: 'com.example.veraClinic',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCj9thDg5HsiJhSi4ROJwCiivGFixEaj6I',
    appId: '1:646096833745:web:5d650bef6f7ff02fe8c9f0',
    messagingSenderId: '646096833745',
    projectId: 'vera-life-clinic',
    authDomain: 'vera-life-clinic.firebaseapp.com',
    storageBucket: 'vera-life-clinic.firebasestorage.app',
    measurementId: 'G-5HF21BDL1Z',
  );
}
