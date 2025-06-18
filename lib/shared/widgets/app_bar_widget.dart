import 'package:flutter/material.dart';
import 'package:flutter_pokedex/app/config/app_colors.dart';
import 'package:flutter_pokedex/app/config/app_typography.dart';
import 'package:flutter_pokedex/core/constants/app_assets.dart';
import 'package:flutter_pokedex/presentation/pokemon/view/pokemon_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: SvgPicture.asset(
              AppAssets.arrowLeft,
              width: 32.w,
              height: 32.w,
              colorFilter: const ColorFilter.mode(
                AppColors.grayScaleWhite,
                BlendMode.srcIn,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            vm.pokemonSelected.name,
            style: AppTypography().headline.copyWith(
              color: AppColors.grayScaleWhite,
            ),
          ),
          Spacer(),
          Text(
            '#${vm.pokemonSelected.id.toString()}',
            style: AppTypography().subtitle1.copyWith(
              color: AppColors.grayScaleWhite,
            ),
          ),
        ],
      ),
    );
  }
}
