import 'package:either_dart/either.dart';
import '../repositories/auth_repository.dart';
import '../entities/user_entity.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/error/failures.dart';

// Login Use case

class LoginUseCase implements UseCase<UserEntity, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) async {
    return await repository.login(params.email, params.password);
  }
}

class LoginParams {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});
}

// Register Use Case

class RegisterUseCse implements UseCase<UserEntity, RegisterParams> {
  final AuthRepository repository;

  RegisterUseCse(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(RegisterParams params) async {
    return await repository.register(
      params.name,
      params.email,
      params.password,
    );
  }
}

class RegisterParams {
  final String name;
  final String email;
  final String password;

  const RegisterParams({
    required this.name,
    required this.email,
    required this.password,
  });
}

// Check Auth Status Use Case

class CheckAuthStatusUseCase implements UseCase<bool, NoParams> {
  final AuthRepository repository;

  CheckAuthStatusUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.checkAuthStatus();
  }
}

// Logout Use Case

class LogoutUseCase implements UseCase<void, NoParams> {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.logout();
  }
}
