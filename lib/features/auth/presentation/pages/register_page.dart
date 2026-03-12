import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/glass_auth_input.dart';

/// RegisterPage — Where new users create an account.
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onRegisterTapped() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Basic frontend validation
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password must be at least 6 characters')),
      );
      return;
    }

    // Fire the RegisterRequested event to the BLoC
    context.read<AuthBloc>().add(RegisterRequested(name, email, password));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.backgroundDark,
                AppColors.backgroundMedium,
                AppColors.surfaceDark,
              ],
            ),
          ),
          
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
              
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: AppColors.error,
                      ),
                    );
                  } else if (state is AuthAuthenticated) {
                    // Registration successful, go to Home
                    context.go(AppConstants.routeHome);
                  }
                },
                builder: (context, state) {
                  final isLoading = state is AuthLoading;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Back Button
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                          onPressed: () {
                            if (context.canPop()) {
                              context.pop();
                            } else {
                              context.go(AppConstants.routeLogin);
                            }
                          },
                        ),
                      ).animate().fadeIn(),
                      
                      const SizedBox(height: 20),

                      // Welcome Text
                      Text(
                        'Create Account',
                        style: AppTextStyles.heading1,
                      ).animate().fadeIn(delay: 100.ms).slideX(begin: -0.2, end: 0),
                      
                      const SizedBox(height: 8),
                      
                      Text(
                        'Join Spark and find your next adventure.',
                        style: AppTextStyles.bodyLarge,
                      ).animate().fadeIn(delay: 200.ms),
                      
                      const SizedBox(height: 40),

                      // Name Input
                      GlassAuthInput(
                        hintText: 'Full Name',
                        icon: Icons.person_outline,
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                      ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1, end: 0),
                      
                      const SizedBox(height: 20),

                      // Email Input
                      GlassAuthInput(
                        hintText: 'Email address',
                        icon: Icons.email_outlined,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                      ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1, end: 0),
                      
                      const SizedBox(height: 20),

                      // Password Input
                      GlassAuthInput(
                        hintText: 'Password',
                        icon: Icons.lock_outline,
                        controller: _passwordController,
                        isPassword: true,
                      ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1, end: 0),
                      
                      const SizedBox(height: 50),

                      // Register Button
                      SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : _onRegisterTapped,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondary, // Greenish color for Sign Up
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text('Sign Up', style: AppTextStyles.buttonLarge),
                        ),
                      ).animate().fadeIn(delay: 600.ms).scale(),
                      
                      const SizedBox(height: 30),

                      // Login Switcher
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?", style: AppTextStyles.bodyMedium),
                          TextButton(
                            onPressed: () {
                              if (context.canPop()) {
                                context.pop();
                              } else {
                                context.go(AppConstants.routeLogin);
                              }
                            },
                            child: Text(
                              'Login',
                              style: AppTextStyles.buttonSmall.copyWith(
                                color: AppColors.secondary,
                              ),
                            ),
                          ),
                        ],
                      ).animate().fadeIn(delay: 700.ms),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
