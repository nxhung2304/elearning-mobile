import 'dart:math';

import 'package:elearning_mobile/app/router/app_path.dart';
import 'package:elearning_mobile/core/exceptions/app_exception.dart';
import 'package:elearning_mobile/core/exceptions/reset_token_exception.dart';
import 'package:elearning_mobile/core/theme/app_colors.dart';
import 'package:elearning_mobile/core/validators/password_validator.dart';
import 'package:elearning_mobile/features/auth/presentation/controller/reset_password_controller.dart';
import 'package:elearning_mobile/features/auth/presentation/widgets/auth_line_text_field.dart';
import 'package:elearning_mobile/features/auth/presentation/widgets/auth_mini_link.dart';
import 'package:elearning_mobile/features/auth/presentation/widgets/auth_password_strength_meter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  ResetPasswordScreen({super.key, required this.resetPasswordToken});

  String resetPasswordToken;

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();

  bool _obscurePassword = true;
  String? _passwordError;
  String? _passwordConfirmationError;
  int _passwordStrength = 0;

  @override
  void dispose() {
    passwordController.dispose();
    passwordConfirmationController.dispose();
    super.dispose();
  }

  void _onPasswordChanged(String value) {
    _passwordStrength = AuthPasswordStrengthMeter.calculateStrength(value);
    if (_passwordError != null && PasswordValidator.isValid(value)) {
      setState(() => _passwordError = null);
    }
  }

  void _onConfirmPasswordChanged(String value) {
    if (_passwordConfirmationError != null &&
        PasswordValidator.isValid(value)) {
      setState(() => _passwordConfirmationError = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final resetPasswordController = ref.read(
      resetPasswordControllerProvider.notifier,
    );
    final resetPasswordState = ref.watch(resetPasswordControllerProvider);

    ref.listen(resetPasswordControllerProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) {
          final text = error is AppException ? error.message : error.toString();

          if (error is ResetTokenException) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(error.message)));
            context.go(AppPath.forgotPassword);
          } else {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(text)));
          }
        },
        data: (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Reset password Successful!')),
          );
          context.replace(AppPath.signIn);
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
                    : context.go(AppPath.vertifyOtp),
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
                'Đặt mật khẩu mới',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.ink,
                  height: 1.25,
                ),
              ),

              const SizedBox(height: 8),
              Text(
                'Mật khẩu mới phải khác với mật khẩu cũ.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.inkSoft,
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 30),
              const SizedBox(height: 22),
              AuthLineTextField(
                label: 'Mật khẩu mới',
                controller: passwordController,
                obscureText: _obscurePassword,
                onChanged: _onPasswordChanged,
                errorText: _passwordError,
              ),
              const SizedBox(height: 8),
              AuthPasswordStrengthMeter(strength: _passwordStrength),
              const SizedBox(height: 22),
              AuthLineTextField(
                label: 'Xác nhận mật khẩu mới',
                controller: passwordConfirmationController,
                obscureText: _obscurePassword,
                onChanged: _onConfirmPasswordChanged,
                errorText: _passwordConfirmationError,
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
                      child: AuthMiniLink(
                        text: _obscurePassword ? 'Hiện' : 'Ẩn',
                      ),
                    ),
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
                      onPressed: resetPasswordState.isLoading
                          ? null
                          : () => _onResetPasswordPressed(
                              resetPasswordController: resetPasswordController,
                              resetPasswordToken: widget.resetPasswordToken,
                              password: passwordController.text,
                              passwordConfirmation:
                                  passwordConfirmationController.text,
                            ),
                      child: const Text(
                        'Đặt lại mật khẩu',
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
            ],
          ),
        ),
      ),
    );
  }

  void _onResetPasswordPressed({
    required ResetPasswordController resetPasswordController,
    required String resetPasswordToken,
    required String password,
    required String passwordConfirmation,
  }) {
    setState(() {
      _passwordError = PasswordValidator.isValid(password)
          ? null
          : 'Mật khẩu tối thiểu ${PasswordValidator.minLength} ký tự';
      _passwordConfirmationError = PasswordValidator.isValid(password)
          ? null
          : 'Mật khẩu tối thiểu ${PasswordValidator.minLength} ký tự';
    });

    if (_passwordError != null || _passwordConfirmationError != null) return;

    resetPasswordController.resetPassword(
      resetPasswordToken: resetPasswordToken,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
  }
}
