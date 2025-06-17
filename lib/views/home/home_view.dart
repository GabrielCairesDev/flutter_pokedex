import 'package:flutter/material.dart';
import 'package:flutter_pokedex/app/config/app_colors.dart';
import 'package:flutter_pokedex/models.dart/pokemon_model.dart';
import 'package:flutter_pokedex/shared/widgets/back_ground_grid_widget.dart';
import 'package:flutter_pokedex/shared/widgets/grid_view_widget.dart';
import 'package:flutter_pokedex/shared/widgets/home_top_widget.dart';
import 'package:flutter_pokedex/shared/widgets/scaffold_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      backgroundColor: AppColors.identityPrimary,
      body: Padding(
        padding: EdgeInsets.all(4.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeTopWidget(),
            BackGroundGridWidget(
              child: Expanded(
                child: GridViewWidget(
                  listPokemons: [
                    PokemonModel(
                      id: 1,
                      name: 'Bulbasaur',
                      imageUrl:
                          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/32.png',
                      tipos: ['Grass', 'Poison'],
                      weight: 6.9,
                      height: 0.7,
                      moves: ['Tackle', 'Growl'],
                      hp: 45,
                      atk: 49,
                      def: 49,
                      satk: 65,
                      sdef: 65,
                      spd: 45,
                    ),
                    PokemonModel(
                      id: 4,
                      name: 'Charmander',
                      imageUrl:
                          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/132.png',
                      tipos: ['Fire'],
                      weight: 8.5,
                      height: 0.6,
                      moves: ['Scratch', 'Ember'],
                      hp: 39,
                      atk: 52,
                      def: 43,
                      satk: 60,
                      sdef: 50,
                      spd: 65,
                    ),
                    PokemonModel(
                      id: 7,
                      name: 'Squirtle',
                      imageUrl:
                          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/13.png',
                      tipos: ['Water'],
                      weight: 9.0,
                      height: 0.5,
                      moves: ['Tackle', 'Water Gun'],
                      hp: 44,
                      atk: 48,
                      def: 65,
                      satk: 50,
                      sdef: 64,
                      spd: 43,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
