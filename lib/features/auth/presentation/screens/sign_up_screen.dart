import 'package:elearning_mobile/core/exceptions/app_exception.dart';
import 'package:elearning_mobile/features/auth/presentation/controller/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signUpController = ref.read(signUpControllerProvider.notifier);
    final signUpState = ref.watch(signUpControllerProvider);

    ref.listen(signUpControllerProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) {
          final text = error is AppException ? error.message : error.toString();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(text)));
        },
        data: (_) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Sign Up Successful!')));
        },
      );
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email'),
              controller: emailController,
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
              controller: passwordController,
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Confirm Password'),
              controller: confirmPasswordController,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: signUpState.isLoading
                    ? null
                    : () => _onSignUpPressed(
                        signUpController,
                        emailController.text,
                        passwordController.text,
                        confirmPasswordController.text,
                      ),
                child: const Text('Sign Up'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSignUpPressed(
    SignUpController signUpController,
    String email,
    String password,
    String confirmPassword,
  ) {
    signUpController.signUp(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }
}
