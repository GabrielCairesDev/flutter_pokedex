import 'package:flutter/material.dart';
import 'package:flutter_pokedex/app/config/app_typography.dart';
import 'package:flutter_pokedex/core/constants/app_colors.dart';
import 'package:flutter_pokedex/core/extensions/color_opacity_extension.dart';
import 'package:flutter_pokedex/shared/widgets/radio_text_wdiget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SortByWidget {
  void showRightAlignedOverlay(
    BuildContext context, {
    required int groupValue,
    required Function(int?) onChanged,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => overlayEntry.remove(),
          child: Stack(
            children: [
              Positioned.fill(child: Container(color: Colors.black.o(20))),
              Positioned(
                top: 115.h,
                right: 16.w,
                child: Material(
                  elevation: 8,
                  color: Colors.transparent,
                  child: Container(
                    width: 113.w,
                    padding: EdgeInsets.only(
                      bottom: 8.w,
                      top: 8.w,
                      left: 8.h,
                      right: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.identityPrimary,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 16.w,
                            bottom: 12.h,
                            top: 6.h,
                          ),
                          child: Text(
                            'Sort by:',
                            style: AppTypography().subtitle1.copyWith(
                              color: AppColors.grayScaleWhite,
                            ),
                          ),
                        ),
                        Container(
                          width: 105.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: AppColors.grayScaleWhite,
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 12.w,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RadioTextWidget(
                                  groupValue: groupValue,
                                  label: 'Number',
                                  onChanged: (value) {
                                    onChanged(value);
                                    overlayEntry.remove();
                                  },
                                  value: 1,
                                ),
                                SizedBox(height: 8.h),
                                RadioTextWidget(
                                  groupValue: groupValue,
                                  label: 'Name',
                                  onChanged: (value) {
                                    onChanged(value);
                                    overlayEntry.remove();
                                  },
                                  value: 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    overlay.insert(overlayEntry);
  }
}
