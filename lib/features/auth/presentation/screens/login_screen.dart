import 'package:elearning_mobile/app/router/app_path.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Login'),
            TextButton(
              onPressed: () => context.push(AppPath.signUp),
              child: const Text('Create an account'),
            ),
          ],
        ),
      ),
    );
  }
}
