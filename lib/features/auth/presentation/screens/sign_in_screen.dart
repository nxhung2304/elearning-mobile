import 'dart:math';

import 'package:elearning_mobile/app/router/app_path.dart';
import 'package:elearning_mobile/core/exceptions/app_exception.dart';
import 'package:elearning_mobile/core/theme/app_colors.dart';
import 'package:elearning_mobile/features/auth/presentation/controller/sign_in_controller.dart';
import 'package:elearning_mobile/features/auth/presentation/widgets/auth_line_text_field.dart';
import 'package:elearning_mobile/features/auth/presentation/widgets/auth_mini_link.dart';
import 'package:elearning_mobile/features/auth/presentation/widgets/auth_outline_button.dart';
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
  bool _obscurePassword = true;

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
      backgroundColor: AppColors.paper,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(26, 28, 26, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Học tiếp nào',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.ink,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Đăng nhập để tiếp tục lộ trình học của bạn.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.inkSoft,
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 30),
              AuthLineTextField(
                label: 'Email',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 22),
              AuthLineTextField(
                label: 'Mật khẩu',
                controller: passwordController,
                obscureText: _obscurePassword,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                      child: AuthMiniLink(_obscurePassword ? 'Hiện' : 'Ẩn'),
                    ),
                    const AuthMiniLink('Quên mật khẩu?'),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.ink,
                        foregroundColor: AppColors.paper,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      onPressed: signInState.isLoading
                          ? null
                          : () => _onSignInPressed(
                              signInController,
                              emailController.text,
                              passwordController.text,
                            ),
                      child: const Text(
                        'Đăng nhập',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -7,
                    right: 14,
                    child: Transform.rotate(
                      angle: 8 * pi / 180,
                      child: Container(
                        width: 18,
                        height: 18,
                        color: AppColors.highlighter,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 26),
                child: Row(
                  children: [
                    Expanded(child: Divider(color: AppColors.paperLine)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        'hoặc',
                        style: TextStyle(fontSize: 12.5, color: AppColors.inkSoft),
                      ),
                    ),
                    Expanded(child: Divider(color: AppColors.paperLine)),
                  ],
                ),
              ),
              const SizedBox(width: double.infinity, child: AuthOutlineButton('Google')),
              const SizedBox(height: 20),
              Center(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 13, color: AppColors.inkSoft),
                    children: [
                      const TextSpan(text: 'Chưa có tài khoản? '),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: GestureDetector(
                          onTap: () => context.push(AppPath.signUp),
                          child: Text(
                            'Đăng ký',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.ink,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.ink,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
