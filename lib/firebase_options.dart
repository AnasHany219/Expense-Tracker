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
    apiKey: 'AIzaSyCPGB7ShIGraR4NcMXriL8CY6aYd4gSHFg',
    appId: '1:22853537674:web:f250378cd732c00ee5c273',
    messagingSenderId: '22853537674',
    projectId: 'expensetracker-78ab7',
    authDomain: 'expensetracker-78ab7.firebaseapp.com',
    storageBucket: 'expensetracker-78ab7.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyARnZ4j8nW9NaxaUduh9X53BIBF6jqzqWk',
    appId: '1:22853537674:android:4b673718c88f2af5e5c273',
    messagingSenderId: '22853537674',
    projectId: 'expensetracker-78ab7',
    storageBucket: 'expensetracker-78ab7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCZSASWGQ72xeJcbgEYVO_Chch9lgYv_ao',
    appId: '1:22853537674:ios:f1809bf405db1128e5c273',
    messagingSenderId: '22853537674',
    projectId: 'expensetracker-78ab7',
    storageBucket: 'expensetracker-78ab7.appspot.com',
    iosBundleId: 'com.example.expenseTracker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCZSASWGQ72xeJcbgEYVO_Chch9lgYv_ao',
    appId: '1:22853537674:ios:f1809bf405db1128e5c273',
    messagingSenderId: '22853537674',
    projectId: 'expensetracker-78ab7',
    storageBucket: 'expensetracker-78ab7.appspot.com',
    iosBundleId: 'com.example.expenseTracker',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCPGB7ShIGraR4NcMXriL8CY6aYd4gSHFg',
    appId: '1:22853537674:web:4f3ae9dccd26130be5c273',
    messagingSenderId: '22853537674',
    projectId: 'expensetracker-78ab7',
    authDomain: 'expensetracker-78ab7.firebaseapp.com',
    storageBucket: 'expensetracker-78ab7.appspot.com',
  );
}
