import 'dart:async';
import 'dart:math';

import 'package:elearning_mobile/app/router/app_path.dart';
import 'package:elearning_mobile/core/exceptions/app_exception.dart';
import 'package:elearning_mobile/core/exceptions/validation_exception.dart';
import 'package:elearning_mobile/core/theme/app_colors.dart';
import 'package:elearning_mobile/features/auth/presentation/controller/forgot_password_controller.dart';
import 'package:elearning_mobile/features/auth/presentation/controller/vertify_otp_controller.dart';
import 'package:elearning_mobile/features/auth/presentation/widgets/auth_mini_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class VertifyOtpScreen extends ConsumerStatefulWidget {
  final String email;

  const VertifyOtpScreen({super.key, required this.email});

  @override
  ConsumerState<VertifyOtpScreen> createState() => _VertifyOtpScreenState();
}

class _VertifyOtpScreenState extends ConsumerState<VertifyOtpScreen> {
  static const int _otpLength = 6;
  Timer? _timer;
  late int _remainingSeconds;
  int? _remainingAttempts;

  final _otpControllers = List.generate(
    _otpLength,
    (_) => TextEditingController(),
  );
  final _otpFocusNodes = List.generate(_otpLength, (_) => FocusNode());

  _initCooldownOtp() {
    _timer?.cancel();

    _remainingSeconds = 5 * 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _initCooldownOtp();
  }

  @override
  void dispose() {
    for (final controller in _otpControllers) {
      controller.dispose();
    }
    for (final focusNode in _otpFocusNodes) {
      focusNode.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final forgotPasswordController = ref.read(
      forgotPasswordControllerProvider.notifier,
    );
    final isResendingOtp = ref
        .watch(forgotPasswordControllerProvider)
        .isLoading;

    ref.listen(forgotPasswordControllerProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) {
          final text = error is AppException ? error.message : error.toString();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(text)));
        },
        data: (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Mã xác nhận mới đã được gửi.')),
          );
          setState(() => _remainingAttempts = null);
          _resetOtpInput();
          _initCooldownOtp();
        },
      );
    });

    final vertifyOtpState = ref.watch(vertifyOtpControllerProvider);

    ref.listen(vertifyOtpControllerProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) {
          setState(() {
            _remainingAttempts = error is ValidationException
                ? error.remainingAttempts
                : null;
          });
          final text = error is AppException ? error.message : error.toString();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(text)));
        },
        data: (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Xác nhận mã thành công.')),
          );
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
                'Nhập mã xác nhận',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.ink,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Chúng tôi đã gửi mã gồm 6 chữ số đến ${widget.email}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.inkSoft,
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  for (var index = 0; index < _otpLength; index++) ...[
                    if (index > 0) const SizedBox(width: 10),
                    _buildOtpBox(index),
                  ],
                ],
              ),
              const SizedBox(height: 8),
              if (_isOtpExpired)
                Text(
                  'Mã OTP đã hết hạn. Vui lòng gửi lại mã mới.',
                  style: TextStyle(fontSize: 12, color: AppColors.inkSoft),
                )
              else
                Text.rich(
                  TextSpan(
                    text: 'Mã hết hạn sau ',
                    children: [
                      TextSpan(
                        text: _formattedTime,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.ink,
                        ),
                      ),
                    ],
                  ),
                  style: TextStyle(fontSize: 11.5, color: AppColors.inkSoft),
                ),
              if (_remainingAttempts != null && !_isOtpExpired) ...[
                const SizedBox(height: 6),
                Text(
                  'Còn $_remainingAttempts lần thử.',
                  style: TextStyle(fontSize: 11.5, color: AppColors.brick),
                ),
              ],
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
                      onPressed:
                          _canConfirmOtp &&
                              !vertifyOtpState.isLoading &&
                              !isResendingOtp
                          ? _onConfirmOtpPressed
                          : null,
                      child: const Text(
                        'Xác nhận',
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
                      TextSpan(text: 'Chưa nhận được mã? '),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: AuthMiniLink(
                          text: 'Gửi lại',
                          onTap: () =>
                              _onResendOtpPressed(forgotPasswordController),
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

  Widget _buildOtpBox(int index) {
    return SizedBox(
      width: 38,
      child: TextField(
        controller: _otpControllers[index],
        focusNode: _otpFocusNodes[index],
        autofocus: index == 0,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: _otpLength,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: AppColors.ink,
        ),
        cursorColor: AppColors.ink,
        decoration: InputDecoration(
          isDense: true,
          counterText: '',
          contentPadding: const EdgeInsets.only(top: 4, bottom: 9),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.paperLine, width: 1.5),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.ink, width: 2),
          ),
        ),
        onChanged: (value) => _onOtpDigitChanged(index, value),
        enabled: !_isOtpExpired,
      ),
    );
  }

  void _onOtpDigitChanged(int index, String value) {
    if (value.length == 2) {
      _otpControllers[index].text = value[1];
      _onOtpDigitChanged(index, value[1]);
      return;
    }
    if (value.length > 2) {
      _fillOtpFromPaste(value);
    } else if (value.isNotEmpty && index < _otpLength - 1) {
      _otpFocusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _otpFocusNodes[index - 1].requestFocus();
    }
    setState(() {});
  }

  String get _formattedTime {
    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  void _onConfirmOtpPressed() {
    ref
        .read(vertifyOtpControllerProvider.notifier)
        .vertifyOtp(email: widget.email, otpCode: _otpCode);
  }

  bool get _isFilledOtp =>
      _otpControllers.every((controller) => controller.text.isNotEmpty);

  bool get _canConfirmOtp => _isFilledOtp && !_isOtpExpired;

  String get _otpCode =>
      _otpControllers.map((controller) => controller.text).join();

  bool get _isOtpExpired => _remainingSeconds <= 0;

  void _onResendOtpPressed(ForgotPasswordController forgotPasswordController) {
    if (ref.read(forgotPasswordControllerProvider).isLoading) return;

    forgotPasswordController.forgotPassword(email: widget.email);
  }

  void _resetOtpInput() {
    for (final controller in _otpControllers) {
      controller.clear();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _otpFocusNodes.first.requestFocus();
    });
  }

  void _fillOtpFromPaste(String pastedDigits) {
    final digits = pastedDigits.length > _otpLength
        ? pastedDigits.substring(0, _otpLength)
        : pastedDigits;
    for (var index = 0; index < _otpLength; index++) {
      _otpControllers[index].text = index < digits.length ? digits[index] : '';
    }
    _otpFocusNodes[min(digits.length, _otpLength) - 1].requestFocus();
  }
}
