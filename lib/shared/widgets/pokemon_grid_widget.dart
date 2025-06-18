import 'package:flutter/material.dart';
import 'package:flutter_pokedex/models/pokemon_model.dart';
import 'package:flutter_pokedex/shared/widgets/pokemon_card_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PokemonGridWidget extends StatelessWidget {
  const PokemonGridWidget({
    super.key,
    required this.listPokemons,
    required this.onTap,
  });

  final List<PokemonModel> listPokemons;
  final Function(PokemonModel) onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Padding(
        padding: EdgeInsets.only(top: 12.h, left: 12.w, right: 12.w),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 8.h,
          mainAxisSpacing: 8.w,
          childAspectRatio: 104.w / 104.w,
          clipBehavior: Clip.none,
          children: List.generate(listPokemons.length, (index) {
            return InkWell(
              onTap: () => onTap(listPokemons[index]),
              child: PokemonCardWidget(pokemon: listPokemons[index]),
            );
          }),
        ),
      ),
    );
  }
}
