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
    apiKey: 'AIzaSyBeFzayi_niCDY3WqBXZYqR_Pyk0osl868',
    appId: '1:925942846141:web:0d403698ab478636a21dd4',
    messagingSenderId: '925942846141',
    projectId: 'customer-management-6f127',
    authDomain: 'customer-management-6f127.firebaseapp.com',
    storageBucket: 'customer-management-6f127.appspot.com',
    measurementId: 'G-F8JM7NRY1N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCv2cquFp5Z1YFBCCJKPMMaQqNOl6Wddxk',
    appId: '1:925942846141:android:70cf1325b4c48a7aa21dd4',
    messagingSenderId: '925942846141',
    projectId: 'customer-management-6f127',
    storageBucket: 'customer-management-6f127.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCTzrz2l2AF_i8yv_BUKFIvE-r55tXMVTU',
    appId: '1:925942846141:ios:716f3083d7ef56cda21dd4',
    messagingSenderId: '925942846141',
    projectId: 'customer-management-6f127',
    storageBucket: 'customer-management-6f127.appspot.com',
    androidClientId: '925942846141-27nrrqaoifiba1vmmbdoskmdhifam88s.apps.googleusercontent.com',
    iosClientId: '925942846141-gsgqbufe3q2loajqcpobgquppn1esorc.apps.googleusercontent.com',
    iosBundleId: 'com.korea.gofit.wellness',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCTzrz2l2AF_i8yv_BUKFIvE-r55tXMVTU',
    appId: '1:925942846141:ios:baf79eaa69af78dea21dd4',
    messagingSenderId: '925942846141',
    projectId: 'customer-management-6f127',
    storageBucket: 'customer-management-6f127.appspot.com',
    androidClientId: '925942846141-27nrrqaoifiba1vmmbdoskmdhifam88s.apps.googleusercontent.com',
    iosClientId: '925942846141-jl1p3hsu1e6at1v3r8ub5e5f7n3ttrg5.apps.googleusercontent.com',
    iosBundleId: 'com.example.gofit.RunnerTests',
  );
}
