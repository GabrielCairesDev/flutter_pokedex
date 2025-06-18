import 'package:flutter/material.dart';
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
    return SizedBox(
      height: 96.h,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...[hp, atk, def, satk, sdef, spd].map(
                (label) => Container(
                  width: 233,
                  height: 4,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
