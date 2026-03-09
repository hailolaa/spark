import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String name, String email, String password);
  Future<void> logout();
  Future<bool> checkAuthStatus();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences prefs;

  AuthLocalDataSourceImpl(this.prefs);

  @override
  Future<UserModel> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    if (email == 'admin@spark.com' && password == 'admin123') {
      final adminUser = UserModel(
        id: 'admin_1',
        name: 'Spark Admin',
        email: email,
        role: AppConstants.roleAdmin,
      );

      await _saveUserSession(adminUser);
      return adminUser;
    }

    final savedEmail = prefs.getString(AppConstants.keyUserEmail);
    final savedPassword = prefs.getString('user_password');

    if (savedEmail == email && savedPassword == password) {
      final name = prefs.getString(AppConstants.keyUserName) ?? 'user';

      final user = UserModel(
        id: 'user_1',
        name: name,
        email: email,
        role: AppConstants.roleUser,
      );
      await _saveUserSession(user);
      return user;
    }

    throw const AuthException('Invalid email or password');
  }

  @override
  Future<UserModel> register(String name, String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    if (email.isEmpty || password.length < 6) {
      throw const AuthException(
        'Invalid registration details. password must be 6+ chars',
      );
    }

    await prefs.setString(AppConstants.keyUserEmail, email);
    await prefs.setString('user_password', password);
    await prefs.setString(AppConstants.keyUserName, name);

    final newUser = UserModel(
      id: 'user_1',
      name: name,
      email: email,
      role: AppConstants.roleUser,
    );

    await _saveUserSession(newUser);
    return newUser;
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    await prefs.setBool(AppConstants.keyIsLoggedIn, false);
  }

  @override
  Future<bool> checkAuthStatus() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return prefs.getBool(AppConstants.keyIsLoggedIn) ?? false;
  }

  //Helper Methods

  Future<void> _saveUserSession(UserModel user) async {
    await prefs.setBool(AppConstants.keyIsLoggedIn, true);
    await prefs.setString(AppConstants.keyUserRole, user.role);
  }
}

class AuthException implements Exception {
  final String message;
  const AuthException(this.message);
}
