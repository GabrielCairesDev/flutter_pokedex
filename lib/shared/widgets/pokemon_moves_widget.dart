import 'package:flutter/material.dart';
import 'package:flutter_pokedex/core/constants/app_colors.dart';
import 'package:flutter_pokedex/app/config/app_typography.dart';
import 'package:flutter_pokedex/data/models/pokemon_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PokemonMovesWidget extends StatelessWidget {
  const PokemonMovesWidget({super.key, required this.pokemon});

  final PokemonModel pokemon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: pokemon.moves.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: Center(
                    child: Text(
                      pokemon.moves[index],
                      style: AppTypography().body3.copyWith(
                        color: AppColors.grayScaleDark,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            'Moves',
            style: AppTypography().body2.copyWith(
              color: AppColors.grayScaleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
