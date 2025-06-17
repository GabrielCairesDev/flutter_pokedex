import 'package:flutter/material.dart';
import 'package:flutter_pokedex/models/pokemon_model.dart';
import 'package:flutter_pokedex/shared/widgets/grid_Item_pokemon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({super.key, required this.listPokemons});

  final List<PokemonModel> listPokemons;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Padding(
        padding: EdgeInsets.only(top: 12.h, left: 12.w, right: 12.w),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 8.h,
          mainAxisSpacing: 8.w,
          childAspectRatio: 104.w / 108.h,
          clipBehavior: Clip.none,
          children: List.generate(listPokemons.length, (index) {
            return GridItemPokemon(pokemon: listPokemons[index]);
          }),
        ),
      ),
    );
  }
}
