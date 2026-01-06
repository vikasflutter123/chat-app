
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;


class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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
    apiKey: 'AIzaSyDtAimGVFGNTv-2Q82-vg_DNSB5WY7nTXQ',
    appId: '1:94653838024:android:de37f475b31dc8d3376bfd',
    messagingSenderId: '94653838024',
    projectId: 'flutter-chat-app-vikas',
    storageBucket: 'flutter-chat-app-vikas.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDgrp0ZWdolJBtmEzzHuvxMl7idoJkBLxI',
    appId: '1:94653838024:ios:be4418a7665794eb376bfd',
    messagingSenderId: '94653838024',
    projectId: 'flutter-chat-app-vikas',
    storageBucket: 'flutter-chat-app-vikas.firebasestorage.app',
    iosBundleId: 'com.example.flutterChat',
  );
}
