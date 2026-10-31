import 'package:elearning_mobile/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
  });

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading) ...[
          ModalBarrier(
            dismissible: false,
            color: Colors.black.withValues(alpha: 0.5),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.ink),
                  strokeWidth: 5,
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
