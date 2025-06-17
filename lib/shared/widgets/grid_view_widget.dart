import 'package:flutter/material.dart';
import 'package:flutter_pokedex/app/config/app_colors.dart';
import 'package:flutter_pokedex/app/config/app_typography.dart';
import 'package:flutter_pokedex/models.dart/pokemon_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({super.key, required this.listPokemons});

  final List<PokemonModel> listPokemons;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 8.h,
      mainAxisSpacing: 8.w,
      childAspectRatio: 104.w / 108.h,
      clipBehavior: Clip.none,
      children: List.generate(listPokemons.length, (index) {
        final pokemon = listPokemons[index];

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: AppColors.grayScaleWhite,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(0, 1),
                blurRadius: 1.5,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                top: 67.h - 3.h,
                left: 0,
                right: 0,
                child: Container(
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: AppColors.grayScaleBackground,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(8.r),
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          '#${pokemon.id}',
                          style: AppTypography().caption.copyWith(
                            color: AppColors.grayScaleMedium,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 72.h,
                        width: 72.w,
                        child: pokemon.imageUrl.isNotEmpty
                            ? Image.network(pokemon.imageUrl)
                            : Container(
                                color: Colors.blue,
                              ), // Caso não tenha imagem
                      ),
                      Text(
                        pokemon.name,
                        style: AppTypography().body3.copyWith(
                          color: AppColors.grayScaleDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
