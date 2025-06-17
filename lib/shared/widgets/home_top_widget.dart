import 'package:flutter/material.dart';
import 'package:flutter_pokedex/app/config/app_colors.dart';
import 'package:flutter_pokedex/app/config/app_typography.dart';
import 'package:flutter_pokedex/core/constants/app_assets.dart';
import 'package:flutter_pokedex/shared/widgets/hash_tag_button_widget.dart';
import 'package:flutter_pokedex/shared/widgets/search_bar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeTopWidget extends StatelessWidget {
  const HomeTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 12.h,
        left: 12.h,
        top: 12.w,
        bottom: 24.w,
      ),
      child: Column(
        children: [
          Row(
            children: [
              _Icon(),
              SizedBox(width: 16.w),
              _Title(),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(child: SearchBarWidget()),
              SizedBox(width: 16.w),
              HashTagButtonWidget(),
            ],
          ),
        ],
      ),
    );
  }
}

class _Icon extends StatelessWidget {
  const _Icon();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: SvgPicture.asset(
        AppAssets.pokeball,
        width: 24.w,
        height: 24.h,
        colorFilter: const ColorFilter.mode(
          AppColors.grayScaleWhite,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Pokédex',
      style: AppTypography().headline.copyWith(color: AppColors.grayScaleWhite),
    );
  }
}
