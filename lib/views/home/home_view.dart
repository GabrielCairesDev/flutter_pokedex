import 'package:flutter/material.dart';
import 'package:flutter_pokedex/app/config/app_colors.dart';
import 'package:flutter_pokedex/shared/widgets/home_top_widget.dart';
import 'package:flutter_pokedex/shared/widgets/scaffold_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      backgroundColor: AppColors.identityPrimary,
      body: Padding(
        padding: EdgeInsets.all(4.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [HomeTopWidget()],
        ),
      ),
    );
  }
}
