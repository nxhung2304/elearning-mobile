import 'package:elearning_mobile/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AuthOutlineButton extends StatelessWidget {
  const AuthOutlineButton(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.ink, width: 1.4),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.ink,
        ),
      ),
    );
  }
}
