import 'package:flutter/material.dart';
import 'package:flutter_pokedex/presentation/home/view/home_view.dart';

class AppRoutes {
  static const String home = '/home';

  static Map<String, WidgetBuilder> get routes => {
    home: (context) => HomeView(),
  };
}
