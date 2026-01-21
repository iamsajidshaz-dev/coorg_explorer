import 'package:coorgtheexplorer/core/errors/exceptions.dart';
import 'package:equatable/equatable.dart';

/// Base failure class
abstract class Failure extends Equatable {
  final String message;
  final String? code;
  
  const Failure(this.message, [this.code]);
  
  @override
  List<Object?> get props => [message, code];
  
  @override
  String toString() => message;
}

/// Server failure
class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error occurred', super.code]);
}

/// Cache failure
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache error occurred', super.code]);
}

/// Network failure
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection', super.code]);
}

/// Authentication failure
class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Authentication failed', super.code]);
}

/// Firebase failure
class FirebaseFailure extends Failure {
  const FirebaseFailure([super.message = 'Firebase error occurred', super.code]);
}

/// Data parsing failure
class ParsingFailure extends Failure {
  const ParsingFailure([super.message = 'Data parsing failed', super.code]);
}

/// Not found failure
class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'Resource not found', super.code]);
}

/// Unauthorized failure
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([super.message = 'Unauthorized access', super.code]);
}

/// Unknown failure
class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'An unknown error occurred', super.code]);
}

// Helper function to convert exceptions to failures
Failure exceptionToFailure(Exception exception) {
  if (exception is ServerException) {
    return ServerFailure(exception.message, exception.code);
  } else if (exception is CacheException) {
    return CacheFailure(exception.message, exception.code);
  } else if (exception is NetworkException) {
    return NetworkFailure(exception.message, exception.code);
  } else if (exception is AuthException) {
    return AuthFailure(exception.message, exception.code);
  } else if (exception is FirebaseException) {
    return FirebaseFailure(exception.message, exception.code);
  } else if (exception is ParsingException) {
    return ParsingFailure(exception.message, exception.code);
  } else if (exception is NotFoundException) {
    return NotFoundFailure(exception.message, exception.code);
  } else if (exception is UnauthorizedException) {
    return UnauthorizedFailure(exception.message, exception.code);
  } else {
    return UnknownFailure(exception.toString());
  }
}