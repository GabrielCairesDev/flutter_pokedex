import 'package:flutter/material.dart';
import 'package:flutter_pokedex/app/config/app_typography.dart';
import 'package:flutter_pokedex/core/constants/app_colors.dart';
import 'package:flutter_pokedex/app/routes/app_routes.dart';
import 'package:flutter_pokedex/main.dart';
import 'package:flutter_pokedex/shared/widgets/back_ground_grid_widget.dart';
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
  final vm = HomeViewModel(syncPokemonCacheUseCase: getIt());

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
                HomeTopWidget(
                  controller: vm.searchController,
                  onChanged: (p0) => vm.searching(),
                  onChangedRadio: (p0) => vm.onChangedRadio(p0),
                  groupValue: vm.groupValue,
                ),
                Expanded(child: BackGroundGridWidget(child: _buildContent())),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Constrói o conteúdo principal baseado no estado atual.
  Widget _buildContent() {
    if (vm.isLoading) {
      return Center(
        child: Text(
          'Carregando Pokémons...',
          style: AppTypography().subtitle1.copyWith(
            color: AppColors.identityPrimary,
          ),
        ),
      );
    }

    if (vm.hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: AppColors.identityPrimary,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              'Erro ao carregar Pokémons',
              style: AppTypography().subtitle1.copyWith(
                color: AppColors.identityPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              vm.errorMessage ?? 'Erro desconhecido',
              style: AppTypography().body1.copyWith(
                color: AppColors.identityPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: vm.retry,
              icon: const Icon(Icons.refresh),
              label: const Text('Tentar Novamente'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.identityPrimary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (vm.pokemons.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, color: AppColors.identityPrimary, size: 64),
            SizedBox(height: 16),
            Text(
              'Nenhum Pokémon encontrado',
              style: AppTypography().subtitle1.copyWith(
                color: AppColors.identityPrimary,
              ),
            ),
          ],
        ),
      );
    }

    return PokemonGridWidget(
      listPokemons: vm.pokemons,
      onTap: (pokemon) {
        vm.selectPokemon(pokemon);
        Navigator.pushNamed(context, AppRoutes.pokemon);
      },
    );
  }
}
