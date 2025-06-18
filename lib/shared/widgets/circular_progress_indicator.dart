import 'package:flutter/material.dart';
import 'package:flutter_pokedex/core/constants/app_colors.dart';

class CircularProgressIndicatorWidget extends StatelessWidget {
  const CircularProgressIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      strokeWidth: 2,
      color: AppColors.identityPrimary,
    );
  }
}
