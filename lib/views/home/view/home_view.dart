import 'package:flutter/material.dart';
import 'package:flutter_pokedex/app/config/app_colors.dart';
import 'package:flutter_pokedex/shared/widgets/back_ground_grid_widget.dart';
import 'package:flutter_pokedex/shared/widgets/grid_view_widget.dart';
import 'package:flutter_pokedex/shared/widgets/home_top_widget.dart';
import 'package:flutter_pokedex/shared/widgets/scaffold_widget.dart';
import 'package:flutter_pokedex/views/home/viewmodel/home_view_model.dart';
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
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: vm,
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
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(height: 16),
                                Text('Carregando...'),
                                Text(
                                  '${vm.qunatityPokemonsCaught} / ${vm.qunatityPokemons}',
                                ),
                              ],
                            ),
                          )
                        : GridViewWidget(listPokemons: vm.listPokemons),
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
