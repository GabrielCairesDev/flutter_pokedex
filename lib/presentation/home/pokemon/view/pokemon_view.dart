import 'package:flutter/material.dart';
import 'package:flutter_pokedex/app/config/app_typography.dart';
import 'package:flutter_pokedex/core/constants/pokemon_type_color.dart';
import 'package:flutter_pokedex/presentation/home/pokemon/viewModel/pokemon_view_model.dart';
import 'package:flutter_pokedex/shared/widgets/app_bar_widget.dart';
import 'package:flutter_pokedex/shared/widgets/big_pokeball_widget.dart';
import 'package:flutter_pokedex/shared/widgets/cached_image_with_loader.dart';
import 'package:flutter_pokedex/shared/widgets/pokemon_body_widget.dart';
import 'package:flutter_pokedex/shared/widgets/white_back_ground_widget.dart';
import 'package:flutter_pokedex/shared/widgets/pokemon_type_widget.dart';
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
                    WhiteBackGroundWidget(),
                    BigPokeball(),
                    Column(
                      children: [
                        AppBarWidget(),
                        Column(
                          children: [
                            CachedImageWithLoader(
                              imageUrl: vm.pokemonSelected.imageUrl,
                              width: 220.w,
                              height: 220.w,
                            ),
                            SizedBox(height: 8.h),
                            PokemonTypeWidget(types: vm.pokemonSelected.types),
                            SizedBox(height: 16.h),
                            Text(
                              'About',
                              style: AppTypography().subtitle1.copyWith(
                                color: PokemonTypeColor.getColor(
                                  vm.pokemonSelected.types[0],
                                ),
                              ),
                            ),
                            SizedBox(height: 16.h),
                            PokemonBodyWidget(pokemon: vm.pokemonSelected),
                          ],
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
