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

    final stats = [hp, atk, def, satk, sdef, spd];

    return SizedBox(  
      height: 96.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: stats.map((stat) {
          return SizedBox(
            width: maxWidth,
            child: LinearProgressIndicator(
              value: stat / maxStats,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              backgroundColor: color.o(20),
              borderRadius: BorderRadius.circular(8.r),
            ),
          );
        }).toList(),
      ),
    );
  }
}
