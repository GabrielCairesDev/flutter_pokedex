import 'package:flutter/material.dart';

extension ColorOpacity on Color {
  Color o(int percent) => withAlpha(((percent / 100) * 255).round());
}
