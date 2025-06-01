import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTypography {
  // Header
  TextStyle headline = TextStyle(
    fontSize: 24.sp,
    height: 24.h / 32.sp,
    fontWeight: FontWeight.bold,
  );

  TextStyle subtitle3 = TextStyle(
    fontSize: 10.sp,
    height: 10.h / 16.sp,
    fontWeight: FontWeight.bold,
  );

  TextStyle subtitle1 = TextStyle(
    fontSize: 14.sp,
    height: 14.h / 16.sp,
    fontWeight: FontWeight.bold,
  );

  TextStyle subtitle2 = TextStyle(
    fontSize: 12.sp,
    height: 12.h / 16.sp,
    fontWeight: FontWeight.bold,
  );

  // Body
  TextStyle body1 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    height: 14.h / 16.sp,
  );

  TextStyle body2 = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    height: 12.h / 16.sp,
  );

  TextStyle body3 = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.normal,
    height: 10.h / 16.sp,
  );

  TextStyle caption = TextStyle(
    fontSize: 8.sp,
    fontWeight: FontWeight.normal,
    height: 8.h / 12.sp,
  );
}
