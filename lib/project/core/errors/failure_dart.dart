// lib/core/errors/failures.dart
abstract class Failure {
  final String message;
  const Failure(this.message);
}

class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}


// Add these new failure types
class NetworkFailure extends Failure {
  final String message;
  NetworkFailure({this.message = 'Network connection error'}) : super('');
}

class CacheFailure extends Failure {
  final String message;
  CacheFailure({this.message = 'Cache error'}) : super('');
}

class ValidationFailure extends Failure {
  final String message;
  ValidationFailure({this.message = 'Validation error'}) : super('');
}