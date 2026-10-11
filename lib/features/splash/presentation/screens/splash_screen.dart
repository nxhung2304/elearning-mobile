import 'dart:math';

import 'package:elearning_mobile/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ink,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _LogoMark(),
            const SizedBox(height: 26),
            Text(
              'Elearning',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.paper,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LogoMark extends StatelessWidget {
  const _LogoMark();

  static const double _width = 76;
  static const double _height = 92;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width,
      height: _height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipPath(
            clipper: _BookmarkClipper(),
            child: Container(width: _width, height: _height, color: AppColors.paper),
          ),
          Positioned(
            right: -6,
            top: _height * 0.35,
            child: Transform.rotate(
              angle: 8 * pi / 180,
              child: Container(width: 22, height: 22, color: AppColors.highlighter),
            ),
          ),
        ],
      ),
    );
  }
}

class _BookmarkClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width / 2, size.height * 0.76)
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
