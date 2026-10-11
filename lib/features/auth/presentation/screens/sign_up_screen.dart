import 'dart:math';

import 'package:elearning_mobile/app/router/app_path.dart';
import 'package:elearning_mobile/core/exceptions/app_exception.dart';
import 'package:elearning_mobile/core/theme/app_colors.dart';
import 'package:elearning_mobile/core/validators/email_validator.dart';
import 'package:elearning_mobile/core/validators/password_validator.dart';
import 'package:elearning_mobile/features/auth/presentation/controller/sign_up_controller.dart';
import 'package:elearning_mobile/features/auth/presentation/widgets/auth_line_text_field.dart';
import 'package:elearning_mobile/features/auth/presentation/widgets/auth_password_strength_meter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool _agreedToTerms = false;
  int _passwordStrength = 0;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _onEmailChanged(String value) {
    if (_emailError != null && EmailValidator.isValid(value)) {
      setState(() => _emailError = null);
    }
  }

  void _onPasswordChanged(String value) {
    setState(() {
      _passwordStrength = AuthPasswordStrengthMeter.calculateStrength(value);
      if (_passwordError != null && PasswordValidator.isValid(value)) {
        _passwordError = null;
      }
      if (_confirmPasswordError != null &&
          value == confirmPasswordController.text) {
        _confirmPasswordError = null;
      }
    });
  }

  void _onConfirmPasswordChanged(String value) {
    if (_confirmPasswordError != null && value == passwordController.text) {
      setState(() => _confirmPasswordError = null);
    }
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
                'Bắt đầu hành trình học',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.ink,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Tạo tài khoản để lưu tiến độ và chứng chỉ của bạn.',
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
                onChanged: _onEmailChanged,
                errorText: _emailError,
              ),
              const SizedBox(height: 22),
              AuthLineTextField(
                label: 'Mật khẩu',
                controller: passwordController,
                obscureText: true,
                onChanged: _onPasswordChanged,
                errorText: _passwordError,
              ),
              const SizedBox(height: 8),
              AuthPasswordStrengthMeter(strength: _passwordStrength),
              const SizedBox(height: 22),
              AuthLineTextField(
                label: 'Xác nhận mật khẩu',
                controller: confirmPasswordController,
                obscureText: true,
                onChanged: _onConfirmPasswordChanged,
                errorText: _confirmPasswordError,
              ),
              const SizedBox(height: 22),
              GestureDetector(
                onTap: () => setState(() => _agreedToTerms = !_agreedToTerms),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 17,
                      height: 17,
                      margin: const EdgeInsets.only(top: 1),
                      decoration: BoxDecoration(
                        color: _agreedToTerms ? AppColors.ink : Colors.transparent,
                        border: Border.all(color: AppColors.ink, width: 1.6),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: _agreedToTerms
                          ? Icon(Icons.check, size: 12, color: AppColors.paper)
                          : null,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(fontSize: 13, color: AppColors.inkSoft),
                          children: [
                            const TextSpan(text: 'Tôi đồng ý với '),
                            TextSpan(
                              text: 'Điều khoản sử dụng',
                              style: TextStyle(
                                color: AppColors.ink,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.inkSoft,
                              ),
                            ),
                            const TextSpan(text: '.'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),
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
                      onPressed: signUpState.isLoading
                          ? null
                          : () => _onSignUpPressed(
                              signUpController,
                              emailController.text,
                              passwordController.text,
                              confirmPasswordController.text,
                            ),
                      child: const Text(
                        'Tạo tài khoản',
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
              const SizedBox(height: 20),
              Center(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 13, color: AppColors.inkSoft),
                    children: [
                      const TextSpan(text: 'Đã có tài khoản? '),
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

  void _onSignUpPressed(
    SignUpController signUpController,
    String email,
    String password,
    String confirmPassword,
  ) {
    setState(() {
      _emailError = EmailValidator.isValid(email) ? null : 'Email không hợp lệ';
      _passwordError = PasswordValidator.isValid(password)
          ? null
          : 'Mật khẩu tối thiểu ${PasswordValidator.minLength} ký tự';
      _confirmPasswordError = confirmPassword == password
          ? null
          : 'Mật khẩu xác nhận không khớp';
    });

    if (_emailError != null ||
        _passwordError != null ||
        _confirmPasswordError != null) {
      return;
    }

    signUpController.signUp(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }
}
