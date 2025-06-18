import 'package:flutter/material.dart';
import 'package:flutter_pokedex/app/config/app_colors.dart';
import 'package:flutter_pokedex/app/config/app_typography.dart';
import 'package:flutter_pokedex/core/constants/pokemon_type_color.dart';
import 'package:flutter_pokedex/models/pokemon_model.dart';
import 'package:flutter_pokedex/shared/widgets/pokemon_body_widget.dart';
import 'package:flutter_pokedex/shared/widgets/pokemon_type_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PokemonDetailsWidget extends StatelessWidget {
  const PokemonDetailsWidget({super.key, required this.pokemon});

  final PokemonModel pokemon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 190.h, right: 4.w, left: 4.w, bottom: 4.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColors.grayScaleWhite,
        ),
        child: Column(
          children: [
            SizedBox(height: 48.h),
            PokemonTypeWidget(types: pokemon.types),
            SizedBox(height: 16.h),
            Text(
              'About',
              style: AppTypography().subtitle1.copyWith(
                color: PokemonTypeColor.getColor(pokemon.types[0]),
              ),
            ),
            SizedBox(height: 16.h),
            PokemonBodyWidget(),
          ],
        ),
      ),
    );
  }
}
