import 'package:elearning_mobile/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AuthPasswordStrengthMeter extends StatelessWidget {
  const AuthPasswordStrengthMeter({super.key, required this.strength});

  final int strength;

  static const int minLength = 8;
  static const int strongLength = 12;
  static const int barCount = 4;

  static int calculateStrength(String password) {
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasDigit = password.contains(RegExp(r'[0-9]'));
    return [
      password.length >= minLength,
      hasUppercase,
      hasDigit,
      password.length >= strongLength,
    ].where((met) => met).length;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(barCount, (index) {
            final isOn = index < strength;
            final isLastBar = index == barCount - 1;
            return Expanded(
              child: Container(
                height: 3,
                margin: EdgeInsets.only(right: isLastBar ? 0 : 4),
                color: isOn ? AppColors.teal : AppColors.paperLine,
              ),
            );
          }),
        ),
        const SizedBox(height: 6),
        Text(
          'Tối thiểu $minLength ký tự, có chữ hoa và số.',
          style: TextStyle(fontSize: 11.5, color: AppColors.inkSoft),
        ),
      ],
    );
  }
}
