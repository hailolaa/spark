import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/glassmorphic_container.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/glass_auth_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Called when the user taps "Login"
  void _onLoginTapped() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Basic validation
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }


    context.read<AuthBloc>().add(LoginRequested(email, password));
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
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
              
              child: BlocConsumer<AuthBloc, AuthState>(
                
                listener: (context, state) {
                  if (state is AuthError) {
                    // Show error message at the bottom of the screen
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: AppColors.error,
                      ),
                    );
                  } else if (state is AuthAuthenticated) {
                    if (state.user.isAdmin) {
                      context.go(AppConstants.routeAdminDashboard);
                    } else {
                      context.go(AppConstants.routeHome);
                    }
                  }
                },
                
                builder: (context, state) {
                  final isLoading = state is AuthLoading;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 40),
                      
                      // 1. Logo
                      Center(
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [AppColors.primary, AppColors.secondary],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.4),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text('⚡', style: TextStyle(fontSize: 40)),
                          ),
                        ).animate().scale(duration: 500.ms, curve: Curves.easeOutBack),
                      ),
                      const SizedBox(height: 40),

                      // 2. Welcome Text
                      Text(
                        'Welcome Back',
                        style: AppTextStyles.heading1,
                        textAlign: TextAlign.center,
                      ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.2, end: 0),
                      
                      const SizedBox(height: 8),
                      
                      Text(
                        'Ready for your next activity?',
                        style: AppTextStyles.bodyLarge,
                        textAlign: TextAlign.center,
                      ).animate().fadeIn(delay: 200.ms),
                      
                      const SizedBox(height: 50),

                      // 3. Email Input
                      GlassAuthInput(
                        hintText: 'Email address',
                        icon: Icons.email_outlined,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                      ).animate().fadeIn(delay: 300.ms).slideX(begin: 0.1, end: 0),
                      
                      const SizedBox(height: 20),

                      // 4. Password Input
                      GlassAuthInput(
                        hintText: 'Password',
                        icon: Icons.lock_outline,
                        controller: _passwordController,
                        isPassword: true,
                      ).animate().fadeIn(delay: 400.ms).slideX(begin: 0.1, end: 0),
                      
                      const SizedBox(height: 12),

                      // 5. Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // TODO: Forgot password
                          },
                          child: Text(
                            'Forgot Password?',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.primaryLight,
                            ),
                          ),
                        ),
                      ).animate().fadeIn(delay: 500.ms),
                      
                      const SizedBox(height: 40),

                      // 6. Login Button
                      SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          // Ignore taps if currently loading
                          onPressed: isLoading ? null : _onLoginTapped,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          // Show a spinner OR text
                          child: isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text('Login', style: AppTextStyles.buttonLarge),
                        ),
                      ).animate().fadeIn(delay: 600.ms).scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1)),
                      
                      const SizedBox(height: 30),

                      // 7. Register Switcher
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?", style: AppTextStyles.bodyMedium),
                          TextButton(
                            onPressed: () {
                              // Navigate to register page
                              context.push(AppConstants.routeRegister);
                            },
                            child: Text(
                              'Sign up',
                              style: AppTextStyles.buttonSmall.copyWith(
                                color: AppColors.primary,
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
