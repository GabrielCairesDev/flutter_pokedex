import 'package:flutter/material.dart';
import 'package:flutter_pokedex/app/config/app_typography.dart';
import 'package:flutter_pokedex/core/constants/app_colors.dart';

class RadioTextWidget extends StatelessWidget {
  final int value;
  final int groupValue;
  final String label;
  final ValueChanged<int?> onChanged;

  const RadioTextWidget({
    super.key,
    required this.value,
    required this.groupValue,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<int>(
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          value: value,
          groupValue: groupValue,
          activeColor: AppColors.identityPrimary,
          onChanged: onChanged,
        ),
        Text(
          label,
          style: AppTypography().body2.copyWith(color: AppColors.grayScaleDark),
        ),
      ],
    );
  }
}
