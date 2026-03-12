import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/auth_usecases.dart';

// =========================================================================
// 📨 EVENTS (Inputs from the UI to the BLoC)
// =========================================================================
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Dispatched when the splash screen loads to see if we're already logged in.
class CheckAuthRequested extends AuthEvent {}

/// Dispatched when the user taps "Login"
class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

/// Dispatched when the user taps "Register"
class RegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const RegisterRequested(this.name, this.email, this.password);

  @override
  List<Object?> get props => [name, email, password];
}

/// Dispatched when the user taps "Logout"
class LogoutRequested extends AuthEvent {}

// =========================================================================
// 🪧 STATES (Outputs from the BLoC to the UI)
// =========================================================================
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// The app just started, we don't know anything yet.
class AuthInitial extends AuthState {}

/// The BLoC is working (show a spinner in the UI).
class AuthLoading extends AuthState {}

/// We successfully logged in or verified we are logged in!
/// We pass the specific [UserEntity] to the UI so it knows who is logged in.
class AuthAuthenticated extends AuthState {
  final UserEntity user;

  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

/// We are NOT logged in (show the login screen).
class AuthUnauthenticated extends AuthState {}

/// Something went wrong (show a SnackBar error).
class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

// =========================================================================
// 🧠 BLOC (The Engine)
// =========================================================================
/// AuthBloc — Listens for AuthEvents, calls UseCases, emits AuthStates.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // We inject all the UseCases we need via the constructor.
  final CheckAuthStatusUseCase checkAuthStatus;
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;

  AuthBloc({
    required this.checkAuthStatus,
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
  }) : super(AuthInitial()) {
    
    // Register event handlers
    // "When X event happens, run Y method"
    on<CheckAuthRequested>(_onCheckAuthRequested);
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  /// Handles [CheckAuthRequested]
  Future<void> _onCheckAuthRequested(
    CheckAuthRequested event,
    Emitter<AuthState> emit,
  ) async {
    // 1. Tell UI we are checking (optional here, but good practice)
    emit(AuthLoading());

    // 2. Call the UseCase
    final result = await checkAuthStatus(NoParams());

    // 3. Handle the Either result
    result.fold(
      (failure) => emit(const AuthError('Could not check auth status')),
      (isLoggedIn) {
        if (isLoggedIn) {
          // If logged in, we SHOULD get the user data here.
          // For Phase 2 simplicity, we'll emit a placeholder user so routing works.
          // In a real app, 'checkAuthStatus' would return the User object directly.
          emit(const AuthAuthenticated(UserEntity(
            id: 'resume', 
            email: 'saved@local.com', 
            name: 'Saved User', 
            role: 'user'
          )));
        } else {
          emit(AuthUnauthenticated());
        }
      },
    );
  }

  /// Handles [LoginRequested]
  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    // 1. Tell UI to show spinner
    emit(AuthLoading());

    // 2. Call the UseCase with params from the Event
    final result = await loginUseCase(LoginParams(
      email: event.email,
      password: event.password,
    ));

    // 3. Emit success or error based on the result
    result.fold(
      (failure) => emit(AuthError(failure.message)), // UI shows standard Failure message
      (user) => emit(AuthAuthenticated(user)),       // UI navigates to Home
    );
  }

  /// Handles [RegisterRequested]
  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await registerUseCase(RegisterParams(
      name: event.name,
      email: event.email,
      password: event.password,
    ));

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  /// Handles [LogoutRequested]
  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await logoutUseCase(NoParams());
    
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthUnauthenticated()), // Go back to login screen
    );
  }
}
