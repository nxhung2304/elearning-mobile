import 'package:elearning_mobile/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AuthMiniLink extends StatelessWidget {
  const AuthMiniLink({required this.text, this.onTap, super.key});

  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.w500,
          color: AppColors.ink,
          decoration: TextDecoration.underline,
          decorationColor: AppColors.inkSoft,
        ),
      ),
    );
  }
}
