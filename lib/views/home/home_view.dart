import 'package:flutter/material.dart';
import 'package:flutter_pokedex/app/config/app_colors.dart';
import 'package:flutter_pokedex/core/constants/app_assets.dart';
import 'package:flutter_pokedex/shared/widgets/scaffold_widget.dart';
import 'package:flutter_svg/svg.dart';

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
      body: Column(
        children: [
          SvgPicture.asset(
            AppAssets.pokeball,
            width: 100,
            height: 100,
            color: Colors.white,
          ),
          Container(),
        ],
      ),
    );
  }
}
