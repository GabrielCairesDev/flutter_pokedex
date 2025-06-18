import 'package:flutter/material.dart';
import 'package:flutter_pokedex/app/config/app_colors.dart';
import 'package:flutter_pokedex/presentation/pokemon/viewModel/pokemon_view_model.dart';
import 'package:flutter_pokedex/shared/widgets/app_bar_widget.dart';
import 'package:flutter_pokedex/shared/widgets/big_pokeball_widget.dart';
import 'package:flutter_pokedex/shared/widgets/cached_image_with_loader.dart';
import 'package:flutter_pokedex/shared/widgets/white_back_ground_widget.dart';
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
                    WhiteBackGroundWidget(pokemonSelected: vm.pokemonSelected),
                    BigPokeball(),
                    Column(
                      children: [
                        AppBarWidget(),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                right: 10.w,
                                left: 10.w,
                                top: 8.h,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    child: Visibility(
                                      visible: !vm.isFirstPokemon,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.chevron_left_outlined,
                                          color: AppColors.grayScaleWhite,
                                        ),
                                        iconSize: 40,
                                        onPressed: () =>
                                            vm.selectPokemonPrevious(),
                                      ),
                                    ),
                                  ),

                                  CachedImageWithLoader(
                                    imageUrl: vm.pokemonSelected.imageUrl,
                                    width: 200.w,
                                    height: 200.w,
                                  ),

                                  SizedBox(
                                    child: Visibility(
                                      visible: !vm.isLastPokemon,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.chevron_right_outlined,
                                          color: AppColors.grayScaleWhite,
                                        ),
                                        iconSize: 40,
                                        onPressed: () => vm.selectPokemonNext(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
