import 'package:flutter/material.dart';
import 'package:flutter_pokedex/app/config/app_colors.dart';
import 'package:flutter_pokedex/app/config/app_typography.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PokemonStatsNumbWidget extends StatelessWidget {
  const PokemonStatsNumbWidget({
    super.key,
    required this.hp,
    required this.atk,
    required this.def,
    required this.satk,
    required this.sdef,
    required this.spd,
  });

  final String hp;
  final String atk;
  final String def;
  final String satk;
  final String sdef;
  final String spd;

  String formatStat(String value) {
    final intVal = int.tryParse(value) ?? 0;
    return intVal.toString().padLeft(3, '0');
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTypography().body3.copyWith(
      color: AppColors.grayScaleDark,
    );

    final stats = [hp, atk, def, satk, sdef, spd];

    return SizedBox(
      height: 96.h,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: stats
                .map((label) => Text(formatStat(label), style: textStyle))
                .toList(),
          ),
        ],
      ),
    );
  }
}
