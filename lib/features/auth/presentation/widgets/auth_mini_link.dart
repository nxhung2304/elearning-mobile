import 'package:elearning_mobile/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AuthMiniLink extends StatelessWidget {
  const AuthMiniLink(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12.5,
        fontWeight: FontWeight.w500,
        color: AppColors.ink,
        decoration: TextDecoration.underline,
        decorationColor: AppColors.inkSoft,
      ),
    );
  }
}
