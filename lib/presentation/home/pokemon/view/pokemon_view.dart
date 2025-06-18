import 'package:flutter/material.dart';
import 'package:flutter_pokedex/presentation/home/pokemon/viewModel/pokemon_view_model.dart';
import 'package:flutter_pokedex/shared/widgets/app_bar_widget.dart';
import 'package:flutter_pokedex/shared/widgets/big_pokeball_widget.dart';
import 'package:flutter_pokedex/shared/widgets/cached_image_with_loader.dart';
import 'package:flutter_pokedex/shared/widgets/pokemon_details_widget.dart';
import 'package:flutter_pokedex/shared/widgets/scaffold_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PokemonView extends StatefulWidget {
  const PokemonView({super.key});

  @override
  State<PokemonView> createState() => _PokemonViewState();
}

final vm = PokemonViewModel();

class _PokemonViewState extends State<PokemonView> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: vm,
      builder: (context, _) {
        return ScaffoldWidget(
          backgroundColor: vm.pokemonSelected.color,
          body: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    PokemonDetailsWidget(pokemon: vm.pokemonSelected),
                    BigPokeball(),
                    Column(
                      children: [
                        AppBarWidget(),
                        CachedImageWithLoader(
                          imageUrl: vm.pokemonSelected.imageUrl,
                          width: 200.w,
                          height: 200.w,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
