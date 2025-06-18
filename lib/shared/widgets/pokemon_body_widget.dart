import 'package:flutter/material.dart';
import 'package:flutter_pokedex/core/constants/app_assets.dart';
import 'package:flutter_pokedex/data/models/pokemon_model.dart';
import 'package:flutter_pokedex/shared/widgets/pokemon_moves_widget.dart';
import 'package:flutter_pokedex/shared/widgets/weight_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PokemonBodyWidget extends StatelessWidget {
  const PokemonBodyWidget({super.key, required this.pokemon});

  final PokemonModel pokemon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      height: 48.h,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          WeightInfoWidget(
            iconAsset: AppAssets.weight,
            weightText: '${pokemon.weight} kg',
            label: 'Weight',
          ),
          VerticalDivider(),
          WeightInfoWidget(
            iconAsset: AppAssets.height,
            weightText: '${pokemon.weight} m',
            label: 'Height',
          ),
          VerticalDivider(),
          PokemonMovesWidget(pokemon: pokemon),
        ],
      ),
    );
  }
}
