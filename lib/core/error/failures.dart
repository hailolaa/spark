import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({this.message});
  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({String message = 'Server error'})
    : super(message: message);
}

class CacheFailure extends Failure {
  const CacheFailure({String message = 'Cache error'})
    : super(message: message);
}

class AuthFailure extends Failure {
  const AuthFailure({String message = 'Authentication error'})
    : super(message: message);
}

class NetworkFailure extends Failure {
  const NetworkFailure({String message = 'Network error'})
    : super(message: message);
}

class ValidationFailure extends Failure {
  const ValidationFailure({String message = 'Validation error'})
    : super(message: message);
}
