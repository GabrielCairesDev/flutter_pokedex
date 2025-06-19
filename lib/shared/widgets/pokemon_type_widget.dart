import 'package:flutter/material.dart';
import 'package:flutter_pokedex/core/constants/app_colors.dart';
import 'package:flutter_pokedex/app/config/app_typography.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PokemonTypeWidget extends StatelessWidget {
  const PokemonTypeWidget({super.key, required this.types});

  final List<String> types;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: types.asMap().entries.map((entry) {
        final index = entry.key;
        final type = entry.value;

        return Padding(
          padding: EdgeInsets.only(right: index != types.length - 1 ? 16.w : 0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.getColorByPokemonType(type),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              type,
              style: AppTypography().subtitle3.copyWith(
                color: AppColors.grayScaleWhite,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
