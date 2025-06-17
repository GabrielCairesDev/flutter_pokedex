import 'package:flutter/material.dart';
import 'package:flutter_pokedex/app/config/app_colors.dart';
import 'package:flutter_pokedex/core/constants/app_assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HashTagButtonWidget extends StatelessWidget {
  const HashTagButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32.h,
      width: 32.h,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.grayScaleWhite,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0, 1)),
        ],
      ),
      child: Center(
        child: SvgPicture.asset(
          AppAssets.tag,
          width: 16.w,
          height: 16.h,
          colorFilter: const ColorFilter.mode(
            AppColors.identityPrimary,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
