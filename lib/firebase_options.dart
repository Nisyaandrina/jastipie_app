import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;

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
          'DefaultFirebaseOptions have not been configured for linux.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported on this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyArvw4cnjsgL5oK4Xha9LqAOn5t1IE8rIs',
    appId: '1:335193141006:web:3b48ea2a9d35dcbdf4315f',
    messagingSenderId: '335193141006',
    projectId: 'jastipie-app',
    authDomain: 'jastipie-app.firebaseapp.com',
    storageBucket: 'jastipie-app.firebasestorage.app',
    measurementId: 'G-QW5W7YT0LZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBslUY_poGMwoSwEHbEKLZnVUuR7xRSASw',
    appId: '1:335193141006:android:8d548ddb9ef9ec41f4315f',
    messagingSenderId: '335193141006',
    projectId: 'jastipie-app',
    storageBucket: 'jastipie-app.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBCIEJZfSZAFrxset8P9U3E0hyIN4ZH6Qk',
    appId: '1:335193141006:ios:ae1363cd68820880f4315f',
    messagingSenderId: '335193141006',
    projectId: 'jastipie-app',
    storageBucket: 'jastipie-app.firebasestorage.app',
    iosBundleId: 'com.example.jastipieApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBCIEJZfSZAFrxset8P9U3E0hyIN4ZH6Qk',
    appId: '1:335193141006:ios:ae1363cd68820880f4315f',
    messagingSenderId: '335193141006',
    projectId: 'jastipie-app',
    storageBucket: 'jastipie-app.firebasestorage.app',
    iosBundleId: 'com.example.jastipieApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyArvw4cnjsgL5oK4Xha9LqAOn5t1IE8rIs',
    appId: '1:335193141006:web:3a5987244c633f09f4315f',
    messagingSenderId: '335193141006',
    projectId: 'jastipie-app',
    authDomain: 'jastipie-app.firebaseapp.com',
    storageBucket: 'jastipie-app.firebasestorage.app',
    measurementId: 'G-4M3XGN1XYZ',
  );
}
