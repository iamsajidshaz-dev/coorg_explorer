import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signInWithGoogle();
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
  Future<bool> isSignedIn();
  Stream<UserModel?> get authStateChanges;
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.googleSignIn,
    required this.firestore,
  });

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      print('🔐 Starting Google Sign In');

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        throw AuthException('Google Sign In was cancelled');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);

      if (userCredential.user == null) {
        throw AuthException('Failed to sign in with Google');
      }

      final userModel = UserModel.fromFirebaseUser(userCredential.user!);

      await _saveUserToFirestore(userModel);

      print('✅ Google Sign In successful: ${userModel.email}');

      return userModel;
    } on FirebaseAuthException catch (e) {
      print('❌ Firebase Auth Error: ${e.code} - ${e.message}');
      throw AuthException(_getAuthErrorMessage(e.code), e.code);
    } catch (e) {
      print('❌ Sign In Error: $e');
      throw AuthException('Failed to sign in with Google: $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      print('🔐 Signing out');
      await Future.wait([
        firebaseAuth.signOut(),
        googleSignIn.signOut(),
      ]);
      print('✅ Sign out successful');
    } catch (e) {
      print('❌ Sign Out Error: $e');
      throw AuthException('Failed to sign out: $e');
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = firebaseAuth.currentUser;
      
      print('🔍 Checking current user: ${user?.email ?? "null"}');
      
      if (user == null) {
        print('❌ No user signed in');
        return null;
      }

      // Try to get user data from Firestore first
      try {
        final docSnapshot = await firestore
            .collection(AppConstants.collectionUsers)
            .doc(user.uid)
            .get();

        if (docSnapshot.exists) {
          print('✅ User found in Firestore');
          return UserModel.fromJson(docSnapshot.data()!);
        }
      } catch (e) {
        print('⚠️ Firestore fetch failed, using Firebase user: $e');
      }

      // If not in Firestore, create from Firebase User
      final userModel = UserModel.fromFirebaseUser(user);
      print('✅ Created user model from Firebase Auth');
      return userModel;
    } catch (e) {
      print('❌ Get Current User Error: $e');
      return null;
    }
  }

  @override
  Future<bool> isSignedIn() async {
    try {
      final isSignedIn = firebaseAuth.currentUser != null;
      print('🔍 Is signed in: $isSignedIn');
      return isSignedIn;
    } catch (e) {
      print('❌ Is Signed In Error: $e');
      return false;
    }
  }

  @override
  Stream<UserModel?> get authStateChanges {
    return firebaseAuth.authStateChanges().map((user) {
      if (user == null) {
        print('🔄 Auth state changed: No user');
        return null;
      }
      print('🔄 Auth state changed: ${user.email}');
      return UserModel.fromFirebaseUser(user);
    });
  }

  Future<void> _saveUserToFirestore(UserModel user) async {
    try {
      await firestore
          .collection(AppConstants.collectionUsers)
          .doc(user.id)
          .set(
            user.toJson(),
            SetOptions(merge: true),
          );
      print('✅ User saved to Firestore: ${user.id}');
    } catch (e) {
      print('❌ Save User to Firestore Error: $e');
    }
  }

  String _getAuthErrorMessage(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return 'An account already exists with a different sign in method';
      case 'invalid-credential':
        return 'Invalid credentials. Please try again';
      case 'operation-not-allowed':
        return 'This sign in method is not allowed';
      case 'user-disabled':
        return 'This account has been disabled';
      case 'user-not-found':
        return 'No account found with this email';
      case 'wrong-password':
        return 'Incorrect password';
      case 'invalid-verification-code':
        return 'Invalid verification code';
      case 'invalid-verification-id':
        return 'Invalid verification ID';
      case 'network-request-failed':
        return 'Network error. Please check your connection';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later';
      default:
        return 'Authentication failed. Please try again';
    }
  }
}