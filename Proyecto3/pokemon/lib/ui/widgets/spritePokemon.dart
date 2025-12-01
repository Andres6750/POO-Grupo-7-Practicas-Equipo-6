// lib/ui/widgets/spritePokemon.dart

import 'package:flutter/material.dart';

class SpritePokemon extends StatelessWidget {
  final String path;
  final double scale;

  const SpritePokemon({
    super.key,
    required this.path,
    this.scale = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: Image.asset(
        path,
        fit: BoxFit.none,
        filterQuality: FilterQuality.none,
      ),
    );
  }
}
