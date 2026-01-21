import 'package:flutter/material.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/sign_in_with_google.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/is_signed_in.dart';

enum AuthState {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}

class AuthProvider extends ChangeNotifier {
  final SignInWithGoogle signInWithGoogle;
  final SignOut signOut;
  final GetCurrentUser getCurrentUser;
  final IsSignedIn isSignedIn;

  AuthProvider({
    required this.signInWithGoogle,
    required this.signOut,
    required this.getCurrentUser,
    required this.isSignedIn,
  });

  AuthState _state = AuthState.initial;
  UserEntity? _user;
  String? _errorMessage;
  bool _isLoading = false;

  AuthState get state => _state;
  UserEntity? get user => _user;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _state == AuthState.authenticated && _user != null;

  /// Check if user is signed in
  Future<void> checkAuthStatus() async {
    print('🔍 AuthProvider: Checking auth status...');
    _setLoading(true);
    
    // First check if signed in
    final isSignedInResult = await isSignedIn();
    
    await isSignedInResult.fold(
      (failure) async {
        print('❌ AuthProvider: Check auth failed: ${failure.message}');
        _setState(AuthState.unauthenticated);
      },
      (signedIn) async {
        print('📊 AuthProvider: Firebase says signed in: $signedIn');
        if (signedIn) {
          await _loadCurrentUser();
        } else {
          print('⚠️ AuthProvider: No active session found');
          _setState(AuthState.unauthenticated);
        }
      },
    );
    
    _setLoading(false);
    print('✅ AuthProvider: Check complete. Final state: $_state, Has user: ${_user != null}');
  }

  /// Load current user
  Future<void> _loadCurrentUser() async {
    print('👤 AuthProvider: Loading current user...');
    final result = await getCurrentUser();
    
    result.fold(
      (failure) {
        print('❌ AuthProvider: Get current user failed: ${failure.message}');
        _setState(AuthState.unauthenticated);
      },
      (user) {
        if (user != null) {
          _user = user;
          _setState(AuthState.authenticated);
          print('✅ AuthProvider: User loaded successfully');
          print('   Email: ${user.email}');
          print('   Name: ${user.displayName}');
          print('   ID: ${user.id}');
        } else {
          print('⚠️ AuthProvider: getCurrentUser returned null');
          _setState(AuthState.unauthenticated);
        }
      },
    );
  }

  /// Sign in with Google
  Future<bool> signInWithGoogleAccount() async {
    print('🔐 AuthProvider: Starting Google sign in...');
    _setLoading(true);
    _errorMessage = null;

    final result = await signInWithGoogle();

    return result.fold(
      (failure) {
        print('❌ AuthProvider: Sign in failed: ${failure.message}');
        _errorMessage = failure.message;
        _setState(AuthState.error);
        _setLoading(false);
        return false;
      },
      (user) {
        _user = user;
        _setState(AuthState.authenticated);
        _setLoading(false);
        print('✅ AuthProvider: Sign in successful');
        print('   Email: ${user.email}');
        print('   Will persist automatically on mobile');
        return true;
      },
    );
  }

  /// Sign out
  Future<bool> signOutUser() async {
    print('🔐 AuthProvider: Signing out...');
    _setLoading(true);
    _errorMessage = null;

    final result = await signOut();

    return result.fold(
      (failure) {
        print('❌ AuthProvider: Sign out failed: ${failure.message}');
        _errorMessage = failure.message;
        _setLoading(false);
        return false;
      },
      (_) {
        _user = null;
        _setState(AuthState.unauthenticated);
        _setLoading(false);
        print('✅ AuthProvider: Sign out successful');
        return true;
      },
    );
  }

  void _setState(AuthState newState) {
    print('🔄 AuthProvider: State changing from $_state to $newState');
    _state = newState;
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}