import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokedex/shared/widgets/circular_progress_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CachedImageWithLoader extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final Color errorColor;

  const CachedImageWithLoader({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.fit = BoxFit.contain,
    this.errorColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) {
          return Center(
            child: SizedBox(
              width: 24.w,
              height: 24.w,
              child: CircularProgressIndicatorWidget(),
            ),
          );
        },
        errorWidget: (context, url, error) {
          return Container(color: errorColor);
        },
        fit: fit,
      ),
    );
  }
}
