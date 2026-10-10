import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyCz2kkAGjLYlPBBO05SjhN8-b2VKMl9w34',
    appId: '1:707768755269:web:20c5276f919c73ee562f2c',
    messagingSenderId: '707768755269',
    projectId: 'connectme-app-b5e47',
    authDomain: 'connectme-app-b5e47.firebaseapp.com',
    storageBucket: 'connectme-app-b5e47.firebasestorage.app',
    measurementId: 'G-FL3P6B447G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA-WUtMW3jiITE4H1qVTtur_MQsd1TiyjU',
    appId: '1:707768755269:android:3b7dffc1340404d6562f2c',
    messagingSenderId: '707768755269',
    projectId: 'connectme-app-b5e47',
    storageBucket: 'connectme-app-b5e47.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA3wfPvOZZeHKR3xGLqWtiQfTxsVpgcAto',
    appId: '1:707768755269:ios:90cef0a405814e96562f2c',
    messagingSenderId: '707768755269',
    projectId: 'connectme-app-b5e47',
    storageBucket: 'connectme-app-b5e47.firebasestorage.app',
    iosBundleId: 'com.example.connectmeApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA3wfPvOZZeHKR3xGLqWtiQfTxsVpgcAto',
    appId: '1:707768755269:ios:90cef0a405814e96562f2c',
    messagingSenderId: '707768755269',
    projectId: 'connectme-app-b5e47',
    storageBucket: 'connectme-app-b5e47.firebasestorage.app',
    iosBundleId: 'com.example.connectmeApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCz2kkAGjLYlPBBO05SjhN8-b2VKMl9w34',
    appId: '1:707768755269:web:4834cafec5ffbe4a562f2c',
    messagingSenderId: '707768755269',
    projectId: 'connectme-app-b5e47',
    authDomain: 'connectme-app-b5e47.firebaseapp.com',
    storageBucket: 'connectme-app-b5e47.firebasestorage.app',
    measurementId: 'G-ZR1730JQB3',
  );
}
