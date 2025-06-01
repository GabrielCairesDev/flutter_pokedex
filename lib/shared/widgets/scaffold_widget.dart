import 'package:flutter/material.dart';

class ScaffoldWidget extends StatelessWidget {
  const ScaffoldWidget({
    super.key,
    required this.backgroundColor,
    required this.body,
  });

  final Color backgroundColor;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(child: body),
    );
  }
}
