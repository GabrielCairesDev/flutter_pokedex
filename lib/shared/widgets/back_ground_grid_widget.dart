import 'package:flutter/material.dart';
import 'package:flutter_pokedex/core/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackGroundGridWidget extends StatelessWidget {
  const BackGroundGridWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: AppColors.grayScaleWhite,
      ),
      child: child,
    );
  }
}
