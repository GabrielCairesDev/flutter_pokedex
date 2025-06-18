import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PokemonBodyWidget extends StatelessWidget {
  const PokemonBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      height: 58.h,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Container()),
          VerticalDivider(),
          Expanded(child: Container()),
          VerticalDivider(),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
