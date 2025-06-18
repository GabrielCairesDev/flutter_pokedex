import 'package:flutter/material.dart';
import 'package:flutter_pokedex/app/config/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WhiteBackGroundWidget extends StatelessWidget {
  const WhiteBackGroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 190.h, right: 4.w, left: 4.w, bottom: 4.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColors.grayScaleWhite,
        ),
      ),
    );
  }
}
