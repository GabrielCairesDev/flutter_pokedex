import 'package:flutter/material.dart';
import 'package:flutter_pokedex/core/constants/app_colors.dart';
import 'package:flutter_pokedex/app/config/app_typography.dart';
import 'package:flutter_pokedex/core/constants/app_assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/flutter_svg.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTypography().body1.copyWith(
      color: AppColors.grayScaleMedium,
    );

    final borderRadius = BorderRadius.circular(24.r);

    final outlineInputBorder = OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: BorderSide.none,
    );

    return SizedBox(
      height: 32.h,
      child: TextFormField(
        controller: controller,
        style: textStyle,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: textStyle,
          filled: true,
          fillColor: AppColors.grayScaleWhite,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          prefixIcon: _PrefixIcon(),
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          border: OutlineInputBorder(borderRadius: borderRadius),
          focusedErrorBorder: OutlineInputBorder(borderRadius: borderRadius),
          errorBorder: OutlineInputBorder(borderRadius: borderRadius),
          disabledBorder: OutlineInputBorder(borderRadius: borderRadius),
        ),
      ),
    );
  }
}

class _PrefixIcon extends StatelessWidget {
  const _PrefixIcon();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.h),
      child: SvgPicture.asset(
        AppAssets.search,
        width: 16.w,
        height: 16.h,
        colorFilter: const ColorFilter.mode(
          AppColors.identityPrimary,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
