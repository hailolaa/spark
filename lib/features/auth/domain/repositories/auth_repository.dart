import 'package:either_dart/either.dart';
import '../entities/user_entity.dart';
import '../../../../core/error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> checkAuthStatus();

  Future<Either<Failure, UserEntity>> login(String email, String password);

  Future<Either<Failure, UserEntity>> register(
    String name,
    String email,
    String password,
  );

  Future<Either<Failure, void>> logout();
}
