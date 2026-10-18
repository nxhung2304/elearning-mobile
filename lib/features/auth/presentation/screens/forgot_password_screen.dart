import 'dart:math';

import 'package:elearning_mobile/app/router/app_path.dart';
import 'package:elearning_mobile/core/exceptions/app_exception.dart';
import 'package:elearning_mobile/core/theme/app_colors.dart';
import 'package:elearning_mobile/core/validators/email_validator.dart';
import 'package:elearning_mobile/features/auth/presentation/controller/forgot_password_controller.dart';
import 'package:elearning_mobile/features/auth/presentation/widgets/auth_line_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  String? _emailError;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final forgotPasswordController = ref.read(
      forgotPasswordControllerProvider.notifier,
    );
    final forgotPasswordState = ref.watch(forgotPasswordControllerProvider);

    ref.listen(forgotPasswordControllerProvider, (previous, next) {
      if (ModalRoute.of(context)?.isCurrent != true) return;
      next.whenOrNull(
        error: (error, stackTrace) {
          final text = error is AppException ? error.message : error.toString();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(text)));
        },
        data: (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Mã xác nhận đã được gửi tới email của bạn.'),
            ),
          );
          context.push(AppPath.vertifyOtp, extra: emailController.text.trim());
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
              GestureDetector(
                onTap: () => context.canPop()
                    ? context.pop()
                    : context.go(AppPath.signIn),
                child: Text(
                  '← Quay lại',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.inkSoft,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Text(
                'Lấy lại mật khẩu',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.ink,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Nhập email bạn dùng để đăng ký, chúng tôi gửi mã xác nhận qua email đó.',
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
                errorText: _emailError,
                onChanged: _onEmailChanged,
              ),
              const SizedBox(height: 30),
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
                      onPressed: forgotPasswordState.isLoading
                          ? null
                          : () => _onForgotPassword(
                              forgotPasswordController,
                              emailController.text,
                            ),
                      child: const Text(
                        'Gửi mã xác nhận',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
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
              const SizedBox(height: 20),
              Center(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 13, color: AppColors.inkSoft),
                    children: [
                      const TextSpan(text: 'Nhớ ra mật khẩu rồi? '),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: GestureDetector(
                          onTap: () => context.canPop()
                              ? context.pop()
                              : context.go(AppPath.signIn),
                          child: Text(
                            'Đăng nhập',
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

  void _onForgotPassword(
    ForgotPasswordController forgotPasswordController,
    String email,
  ) {
    setState(() {
      _emailError = EmailValidator.isValid(email) ? null : 'Email không hợp lệ';
    });

    if (_emailError != null) return;

    forgotPasswordController.forgotPassword(email: email);
  }

  void _onEmailChanged(String value) {
    if (_emailError != null && EmailValidator.isValid(value)) {
      setState(() => _emailError = null);
    }
  }
}
