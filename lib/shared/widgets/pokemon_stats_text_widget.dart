import 'package:flutter/material.dart';
import 'package:flutter_pokedex/app/config/app_typography.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PokemonStatsTextWidget extends StatelessWidget {
  const PokemonStatsTextWidget({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTypography().subtitle1.copyWith(color: color);
    return SizedBox(
      height: 96.h,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...[
                'HP',
                'ATK',
                'DEF',
                'SATK',
                'SDEF',
                'SPD',
              ].map((label) => Text(label, style: textStyle)),
            ],
          ),
          SizedBox(width: 8.w),
          VerticalDivider(),
        ],
      ),
    );
  }
}
