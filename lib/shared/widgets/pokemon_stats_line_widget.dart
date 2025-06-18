import 'package:flutter/material.dart';
import 'package:flutter_pokedex/core/extensions/color_opacity_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PokemonStatsLineWidget extends StatelessWidget {
  const PokemonStatsLineWidget({
    super.key,
    required this.hp,
    required this.atk,
    required this.def,
    required this.satk,
    required this.sdef,
    required this.spd,
    required this.color,
  });

  final int hp;
  final int atk;
  final int def;
  final int satk;
  final int sdef;
  final int spd;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final maxStats = 255;
    final double maxWidth = 210.w;

    /// Função para calcular o tamanho proporcional da barra
    double calculateWidth(int stat) {
      final percentage = stat / maxStats;
      return maxWidth * percentage;
    }

    /// Lista de stats
    final stats = [hp, atk, def, satk, sdef, spd];

    return SizedBox(
      height: 96.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: stats.map((stat) {
          return Stack(
            children: [
              /// Linha de fundo (background da barra)
              Container(
                width: maxWidth,
                height: 5.h,
                decoration: BoxDecoration(
                  color: color.o(20),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),

              /// Linha da stat (proporcional)
              Container(
                width: calculateWidth(stat),
                height: 5.h,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
