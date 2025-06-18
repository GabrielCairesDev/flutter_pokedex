import 'package:flutter/material.dart';
import 'package:flutter_pokedex/app/config/app_colors.dart';
import 'package:flutter_pokedex/app/routes/app_routes.dart';
import 'package:flutter_pokedex/shared/widgets/back_ground_grid_widget.dart';
import 'package:flutter_pokedex/shared/widgets/circular_progress_indicator.dart';
import 'package:flutter_pokedex/shared/widgets/pokemon_grid_widget.dart';
import 'package:flutter_pokedex/shared/widgets/home_top_widget.dart';
import 'package:flutter_pokedex/shared/widgets/scaffold_widget.dart';
import 'package:flutter_pokedex/presentation/home/viewmodel/home_view_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final vm = HomeViewModel();

  @override
  void initState() {
    super.initState();
    vm.init();
  }

  @override
  void dispose() {
    vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: vm,
      builder: (context, _) {
        return ScaffoldWidget(
          backgroundColor: AppColors.identityPrimary,
          body: Padding(
            padding: EdgeInsets.all(4.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeTopWidget(),
                Expanded(
                  child: BackGroundGridWidget(
                    child: vm.isLoading
                        ? Center(child: CircularProgressIndicatorWidget())
                        : PokemonGridWidget(
                            listPokemons: vm.listPokemons,
                            onTap: (pokemon) {
                              vm.selectPokemon(pokemon);
                              Navigator.pushNamed(context, AppRoutes.pokemon);
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
