import 'package:flutter/material.dart';
import 'package:flutter_pokedex/core/constants/app_colors.dart';
import 'package:flutter_pokedex/app/config/app_typography.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeightInfoWidget extends StatelessWidget {
  final String iconAsset;
  final String weightText;
  final String label;

  const WeightInfoWidget({
    super.key,
    required this.iconAsset,
    required this.weightText,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(top: 8.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  iconAsset,
                  width: 16.w,
                  height: 16.w,
                  colorFilter: const ColorFilter.mode(
                    AppColors.grayScaleDark,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  weightText,
                  style: AppTypography().body3.copyWith(
                    color: AppColors.grayScaleDark,
                  ),
                ),
              ],
            ),

            Text(
              label,
              style: AppTypography().body2.copyWith(
                color: AppColors.grayScaleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
