import 'package:elearning_mobile/core/exceptions/app_exception.dart';
import 'package:elearning_mobile/features/profile/presentation/controller/sign_out_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signOutState = ref.watch(signOutControllerProvider);

    ref.listen(signOutControllerProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) {
          final text = error is AppException ? error.message : error.toString();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(text)));
        },
      );
    });
    return Scaffold(
      body: Column(
        children: [
          const Text('Profile screen'),
          ElevatedButton(
            onPressed: signOutState.isLoading
                ? null
                : () => ref.read(signOutControllerProvider.notifier).signOut(),
            child: const Text('Sign out'),
          ),
        ],
      ),
    );
  }
}
