import 'package:flutter/material.dart';
import 'package:flutter_pokedex/app/config/app_colors.dart';
import 'package:flutter_pokedex/app/config/app_typography.dart';
import 'package:flutter_pokedex/core/constants/pokemon_type_color.dart';
import 'package:flutter_pokedex/models/pokemon_model.dart';
import 'package:flutter_pokedex/shared/widgets/pokemon_body_widget.dart';
import 'package:flutter_pokedex/shared/widgets/pokemon_stats_line_widget.dart';
import 'package:flutter_pokedex/shared/widgets/pokemon_stats_numb_widget.dart';
import 'package:flutter_pokedex/shared/widgets/pokemon_stats_text_widget.dart';
import 'package:flutter_pokedex/shared/widgets/pokemon_type_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WhiteBackGroundWidget extends StatelessWidget {
  const WhiteBackGroundWidget({super.key, required this.pokemonSelected});

  final PokemonModel pokemonSelected;

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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40.h),

            PokemonTypeWidget(types: pokemonSelected.types),
            SizedBox(height: 12.h),
            Text(
              'About',
              style: AppTypography().subtitle1.copyWith(
                color: PokemonTypeColor.getColor(pokemonSelected.types[0]),
              ),
            ),
            SizedBox(height: 12.h),
            PokemonBodyWidget(pokemon: pokemonSelected),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  SizedBox(height: 12.h),
                  Text(
                    pokemonSelected.description,
                    style: AppTypography().body2.copyWith(
                      color: AppColors.grayScaleDark,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Base Stats',
                    style: AppTypography().subtitle1.copyWith(
                      color: PokemonTypeColor.getColor(
                        pokemonSelected.types[0],
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    height: 96.h,
                    child: Row(
                      children: [
                        PokemonStatsTextWidget(
                          color: PokemonTypeColor.getColor(
                            pokemonSelected.types[0],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        VerticalDivider(),
                        SizedBox(width: 8.w),
                        PokemonStatsNumbWidget(
                          hp: pokemonSelected.hpString,
                          atk: pokemonSelected.atkString,
                          def: pokemonSelected.defString,
                          satk: pokemonSelected.satkString,
                          sdef: pokemonSelected.sdefString,
                          spd: pokemonSelected.spdString,
                        ),
                        SizedBox(width: 8.w),
                        PokemonStatsLineWidget(
                          hp: pokemonSelected.hp,
                          atk: pokemonSelected.atk,
                          def: pokemonSelected.def,
                          satk: pokemonSelected.satk,
                          sdef: pokemonSelected.sdef,
                          spd: pokemonSelected.spd,
                          color: PokemonTypeColor.getColor(
                            pokemonSelected.types[0],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
