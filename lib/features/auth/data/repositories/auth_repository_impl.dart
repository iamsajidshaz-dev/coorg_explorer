import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    try {
      final user = await remoteDataSource.signInWithGoogle();
      return Right(user);
    } on AuthException catch (e) {
      AppLogger.error('Auth Exception: ${e.message}');
      return Left(AuthFailure(e.message, e.code));
    } catch (e) {
      AppLogger.error('Unknown Exception: $e');
      return Left(AuthFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(null);
    } on AuthException catch (e) {
      AppLogger.error('Auth Exception: ${e.message}');
      return Left(AuthFailure(e.message, e.code));
    } catch (e) {
      AppLogger.error('Unknown Exception: $e');
      return Left(AuthFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUser();
      return Right(user);
    } catch (e) {
      AppLogger.error('Get Current User Exception: $e');
      return Left(AuthFailure('Failed to get current user'));
    }
  }

  @override
  Future<Either<Failure, bool>> isSignedIn() async {
    try {
      final isSignedIn = await remoteDataSource.isSignedIn();
      return Right(isSignedIn);
    } catch (e) {
      AppLogger.error('Is Signed In Exception: $e');
      return const Right(false);
    }
  }

  @override
  Stream<UserEntity?> get authStateChanges {
    return remoteDataSource.authStateChanges;
  }
}