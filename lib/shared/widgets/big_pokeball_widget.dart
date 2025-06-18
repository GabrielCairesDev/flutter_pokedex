import 'package:flutter/material.dart';
import 'package:flutter_pokedex/app/config/app_colors.dart';
import 'package:flutter_pokedex/core/constants/app_assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BigPokeball extends StatelessWidget {
  const BigPokeball({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.only(right: 10.w),
        child: SvgPicture.asset(
          AppAssets.pokeball,
          width: 205.w,
          height: 205.w,
          colorFilter: ColorFilter.mode(
            AppColors.grayScaleWhite.withOpacity(0.1),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
