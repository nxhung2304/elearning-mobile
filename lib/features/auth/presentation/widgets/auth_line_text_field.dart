import 'package:elearning_mobile/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AuthLineTextField extends StatelessWidget {
  const AuthLineTextField({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.onChanged,
    this.errorText,
  });

  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final hasError = errorText != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
            color: AppColors.inkSoft,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          onChanged: onChanged,
          style: TextStyle(fontSize: 15, color: AppColors.ink),
          cursorColor: AppColors.ink,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.only(bottom: 9),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.paperLine, width: 1.5),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: hasError ? AppColors.brick : AppColors.paperLine,
                width: hasError ? 2 : 1.5,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: hasError ? AppColors.brick : AppColors.ink,
                width: 2,
              ),
            ),
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 6),
          Text(
            errorText!,
            style: TextStyle(fontSize: 11.5, color: AppColors.brick),
          ),
        ],
      ],
    );
  }
}
