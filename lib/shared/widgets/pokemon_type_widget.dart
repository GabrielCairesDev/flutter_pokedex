import 'package:flutter/material.dart';
import 'package:flutter_pokedex/app/config/app_colors.dart';
import 'package:flutter_pokedex/app/config/app_typography.dart';
import 'package:flutter_pokedex/core/constants/pokemon_type_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PokemonTypeWidget extends StatelessWidget {
  const PokemonTypeWidget({super.key, required this.types});

  final List<String> types;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: types
          .map(
            (type) => Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: PokemonTypeColor.getColor(type),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  type,
                  style: AppTypography().subtitle3.copyWith(
                    color: AppColors.grayScaleWhite,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
