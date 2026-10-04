import 'package:elearning_mobile/app/router/app_path.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          ],
        ),
      ),
    );
  }
}
