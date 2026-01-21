import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  /// Sign in with Google
  Future<Either<Failure, UserEntity>> signInWithGoogle();

  /// Sign out
  Future<Either<Failure, void>> signOut();

  /// Get current user
  Future<Either<Failure, UserEntity?>> getCurrentUser();

  /// Check if user is signed in
  Future<Either<Failure, bool>> isSignedIn();

  /// Stream of auth state changes
  Stream<UserEntity?> get authStateChanges;
}
