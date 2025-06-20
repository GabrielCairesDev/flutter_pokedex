import 'package:flutter/material.dart';
import 'package:flutter_pokedex/core/constants/app_colors.dart';
import 'package:flutter_pokedex/app/config/app_typography.dart';
import 'package:flutter_pokedex/core/extensions/color_opacity_extension.dart';
import 'package:flutter_pokedex/data/models/pokemon_model.dart';
import 'package:flutter_pokedex/shared/widgets/cached_image_with_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PokemonCardWidget extends StatelessWidget {
  const PokemonCardWidget({super.key, required this.pokemon});

  final PokemonModel pokemon;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: AppColors.getColorByPokemonType(pokemon.types[0]).o(60),
        boxShadow: [
          BoxShadow(
            color: Colors.black.o(20),
            offset: const Offset(0, 1),
            blurRadius: 1.5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 50.h,
            left: 0,
            right: 0,
            child: Container(
              height: 44.h,
              decoration: BoxDecoration(
                color: AppColors.getColorByPokemonType(pokemon.types[0]),
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      '#${pokemon.id}',
                      style: AppTypography().subtitle2.copyWith(
                        color: AppColors.grayScaleBackground,
                      ),
                    ),
                  ),
                  pokemon.imageUrl.isNotEmpty
                      ? CachedImageWithLoader(
                          imageUrl: pokemon.imageUrl,
                          width: 68.w,
                          height: 68.w,
                        )
                      : Container(color: Colors.blue),
                  Text(
                    pokemon.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography().body2.copyWith(
                      color: AppColors.grayScaleDark,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
