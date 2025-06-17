import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.h,
        mainAxisSpacing: 8.w,
        childAspectRatio: 108.w / 108.h,
      ),
      itemCount: 9,
      itemBuilder: (context, index) {
        return Container(color: Colors.black, height: 108.h, width: 104.w);
      },
    );
  }
}
