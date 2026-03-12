import 'package:either_dart/either.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, UserEntity>> login(String email, String password) async {
    try {
      // Try to get data from the muscle (data source)
      final userModel = await localDataSource.login(email, password);
      // If successful, return it wrapped in Right
      return Right(userModel);
    } on AuthException catch (e) {
      // If the data source threw an AuthException, catch it and return Left(AuthFailure)
      return Left(AuthFailure(message: e.message));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register(String name, String email, String password) async {
    try {
      final userModel = await localDataSource.register(name, email, password);
      return Right(userModel);
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await localDataSource.logout();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to log out: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, bool>> checkAuthStatus() async {
    try {
      final isLoggedIn = await localDataSource.checkAuthStatus();
      return Right(isLoggedIn);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to check auth status: ${e.toString()}'));
    }
  }
}
