import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
      return FirebaseOptions(
        apiKey: dotenv.env['FIREBASE_API_KEY']!,
        appId: dotenv.env['FIREBASE_APP_ID']!,
        messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID']!,
        projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
        storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET']!,
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
