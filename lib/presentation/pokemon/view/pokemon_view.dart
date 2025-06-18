import 'package:flutter/material.dart';
import 'package:flutter_pokedex/app/config/app_colors.dart';
import 'package:flutter_pokedex/app/config/app_typography.dart';
import 'package:flutter_pokedex/core/constants/pokemon_type_color.dart';
import 'package:flutter_pokedex/presentation/pokemon/viewModel/pokemon_view_model.dart';
import 'package:flutter_pokedex/shared/widgets/app_bar_widget.dart';
import 'package:flutter_pokedex/shared/widgets/big_pokeball_widget.dart';
import 'package:flutter_pokedex/shared/widgets/cached_image_with_loader.dart';
import 'package:flutter_pokedex/shared/widgets/pokemon_body_widget.dart';
import 'package:flutter_pokedex/shared/widgets/pokemon_stats_line_widget.dart';
import 'package:flutter_pokedex/shared/widgets/pokemon_stats_numb_widget.dart';
import 'package:flutter_pokedex/shared/widgets/pokemon_stats_text_widget.dart';
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
                            SizedBox(height: 8.h),
                            Text(
                              'About',
                              style: AppTypography().subtitle1.copyWith(
                                color: PokemonTypeColor.getColor(
                                  vm.pokemonSelected.types[0],
                                ),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            PokemonBodyWidget(pokemon: vm.pokemonSelected),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              child: Column(
                                children: [
                                  SizedBox(height: 32.h),
                                  Text(
                                    vm.pokemonSelected.description,
                                    style: AppTypography().body1.copyWith(
                                      color: AppColors.grayScaleDark,
                                    ),
                                  ),
                                  SizedBox(height: 32.h),
                                  Text(
                                    'Base Stats',
                                    style: AppTypography().subtitle1.copyWith(
                                      color: PokemonTypeColor.getColor(
                                        vm.pokemonSelected.types[0],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 32.h),
                                  SizedBox(
                                    height: 96.h,
                                    child: Row(
                                      children: [
                                        PokemonStatsTextWidget(
                                          color: PokemonTypeColor.getColor(
                                            vm.pokemonSelected.types[0],
                                          ),
                                        ),
                                        SizedBox(width: 8.w),
                                        VerticalDivider(),
                                        SizedBox(width: 8.w),
                                        PokemonStatsNumbWidget(
                                          hp: vm.pokemonSelected.hpString,
                                          atk: vm.pokemonSelected.atkString,
                                          def: vm.pokemonSelected.defString,
                                          satk: vm.pokemonSelected.satkString,
                                          sdef: vm.pokemonSelected.sdefString,
                                          spd: vm.pokemonSelected.spdString,
                                        ),
                                        SizedBox(width: 8.w),
                                        PokemonStatsLineWidget(
                                          hp: vm.pokemonSelected.hp,
                                          atk: vm.pokemonSelected.atk,
                                          def: vm.pokemonSelected.def,
                                          satk: vm.pokemonSelected.satk,
                                          sdef: vm.pokemonSelected.sdef,
                                          spd: vm.pokemonSelected.spd,
                                          color: PokemonTypeColor.getColor(
                                            vm.pokemonSelected.types[0],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 24.h),
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
