import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// --- AUTH IMPORTS ---
import 'features/auth/data/datasources/auth_local_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/auth_usecases.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Shared Preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  //Features

  // Auth
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<CheckAuthStatusUseCase>(
    () => CheckAuthStatusUseCase(sl()),
  );
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl()),
  );
  sl.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(sl()),
  );
  sl.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(sl()),
  );
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      checkAuthStatus: sl(),
      loginUseCase: sl(),
      registerUseCase: sl(),
      logoutUseCase: sl(),
    ),
  );
}
