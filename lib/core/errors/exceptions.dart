/// Base exception class
class AppException implements Exception {
  final String message;
  final String? code;
  
  AppException(this.message, [this.code]);
  
  @override
  String toString() => message;
}

/// Server related exceptions
class ServerException extends AppException {
  ServerException([super.message = 'Server error occurred']);
}

/// Cache related exceptions
class CacheException extends AppException {
  CacheException([super.message = 'Cache error occurred']);
}

/// Network related exceptions
class NetworkException extends AppException {
  NetworkException([super.message = 'Network error occurred']);
}

/// Authentication related exceptions
class AuthException extends AppException {
  AuthException(super.message, [super.code]);
}

/// Firebase related exceptions
class FirebaseException extends AppException {
  FirebaseException(super.message, [super.code]);
}

/// Data parsing exceptions
class ParsingException extends AppException {
  ParsingException([super.message = 'Data parsing error occurred']);
}

/// Not found exceptions
class NotFoundException extends AppException {
  NotFoundException([super.message = 'Resource not found']);
}

/// Unauthorized exceptions
class UnauthorizedException extends AppException {
  UnauthorizedException([super.message = 'Unauthorized access']);
}
