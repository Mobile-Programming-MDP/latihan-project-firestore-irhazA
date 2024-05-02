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
    apiKey: 'AIzaSyDxaUmuz42Trl4F-PZf_PRnGXq6qCHOS64',
    appId: '1:972121772867:web:f79f7250aa6b85c90d15f6',
    messagingSenderId: '972121772867',
    projectId: 'flutterfireirhaz',
    authDomain: 'flutterfireirhaz.firebaseapp.com',
    databaseURL: 'https://flutterfireirhaz-default-rtdb.firebaseio.com',
    storageBucket: 'flutterfireirhaz.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDafNr2DfhVLN9GIFB4ROH4hqs4diKRKtY',
    appId: '1:972121772867:android:2779a18589da987c0d15f6',
    messagingSenderId: '972121772867',
    projectId: 'flutterfireirhaz',
    databaseURL: 'https://flutterfireirhaz-default-rtdb.firebaseio.com',
    storageBucket: 'flutterfireirhaz.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDP6Cb0OObTBAEva5e0PVl-Ms8kqBsxnWg',
    appId: '1:972121772867:ios:05727816768e17920d15f6',
    messagingSenderId: '972121772867',
    projectId: 'flutterfireirhaz',
    databaseURL: 'https://flutterfireirhaz-default-rtdb.firebaseio.com',
    storageBucket: 'flutterfireirhaz.appspot.com',
    iosBundleId: 'com.example.flutterlist',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDP6Cb0OObTBAEva5e0PVl-Ms8kqBsxnWg',
    appId: '1:972121772867:ios:05727816768e17920d15f6',
    messagingSenderId: '972121772867',
    projectId: 'flutterfireirhaz',
    databaseURL: 'https://flutterfireirhaz-default-rtdb.firebaseio.com',
    storageBucket: 'flutterfireirhaz.appspot.com',
    iosBundleId: 'com.example.flutterlist',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDxaUmuz42Trl4F-PZf_PRnGXq6qCHOS64',
    appId: '1:972121772867:web:f7a798aa68b91e2a0d15f6',
    messagingSenderId: '972121772867',
    projectId: 'flutterfireirhaz',
    authDomain: 'flutterfireirhaz.firebaseapp.com',
    databaseURL: 'https://flutterfireirhaz-default-rtdb.firebaseio.com',
    storageBucket: 'flutterfireirhaz.appspot.com',
  );

}