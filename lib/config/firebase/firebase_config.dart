import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import '../../core/utils/logger.dart';

class FirebaseConfig {
  static Future<void> initialize() async {
    try {
      await Firebase.initializeApp(
        options: _getFirebaseOptions(),
      );
      AppLogger.info('Firebase initialized successfully');
    } catch (e) {
      AppLogger.error('Firebase initialization failed: $e');
      rethrow;
    }
  }

  static FirebaseOptions _getFirebaseOptions() {
    // For Android
    if (defaultTargetPlatform == TargetPlatform.android) {
      return const FirebaseOptions(
        // apiKey: 'YOUR_ANDROID_API_KEY',
        // appId: 'YOUR_ANDROID_APP_ID',
        // messagingSenderId: 'YOUR_SENDER_ID',
        // projectId: 'YOUR_PROJECT_ID',
        // storageBucket: 'YOUR_STORAGE_BUCKET',

         apiKey: 'AIzaSyDKmrNoachDX9kO1mEXGjcqIDZipRDXC-o',
    appId: '1:1054132185789:android:908469081a8d6405a6a5d4',
    messagingSenderId: '1054132185789',
    projectId: 'coorg-explorer-464c0',
    storageBucket: 'coorg-explorer-464c0.firebasestorage.app',
      );
    }
    // For iOS
    // else if (defaultTargetPlatform == TargetPlatform.iOS) {
    //   return const FirebaseOptions(
    //     apiKey: 'YOUR_IOS_API_KEY',
    //     appId: 'YOUR_IOS_APP_ID',
    //     messagingSenderId: 'YOUR_SENDER_ID',
    //     projectId: 'YOUR_PROJECT_ID',
    //     storageBucket: 'YOUR_STORAGE_BUCKET',
    //     iosClientId: 'YOUR_IOS_CLIENT_ID',
    //     iosBundleId: 'com.futurecraftlab.coorgtheexplorer',
    //   );
    // }
    
    
    throw UnsupportedError('Unsupported platform');
  }
}