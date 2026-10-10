import 'package:elearning_mobile/app/router/app_path.dart';
import 'package:elearning_mobile/core/exceptions/app_exception.dart';
import 'package:elearning_mobile/features/auth/presentation/controller/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});
  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signInController = ref.read(signInControllerProvider.notifier);
    final signInState = ref.watch(signInControllerProvider);

    ref.listen(signInControllerProvider, (previous, next) {
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
          ).showSnackBar(const SnackBar(content: Text('Sign In Successful!')));
        },
      );
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Sign In'),
            TextButton(
              onPressed: () => context.push(AppPath.signUp),
              child: const Text('Create an account'),
            ),
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
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: signInState.isLoading
                    ? null
                    : () => _onSignInPressed(
                        signInController,
                        emailController.text,
                        passwordController.text,
                      ),
                child: const Text('Sign In'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSignInPressed(
    SignInController signInController,
    String email,
    String password,
  ) {
    signInController.signIn(email: email, password: password);
  }
}
