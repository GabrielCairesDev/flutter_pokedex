import 'package:flutter/material.dart';
import 'package:flutter_pokedex/views/home/view/home_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppConfig extends StatelessWidget {
  const AppConfig({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 640),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return MaterialApp(title: 'Pokedex PokeApi', home: HomeView());
      },
    );
  }
}
