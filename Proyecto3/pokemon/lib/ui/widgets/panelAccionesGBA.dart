// lib/ui/widgets/panelAccionesGBA.dart

import 'package:flutter/material.dart';
import 'botonGBA.dart';

class PanelAccionesGBA extends StatelessWidget {
  final VoidCallback onLucha;
  final VoidCallback onMochila;
  final VoidCallback onPokemon;

  const PanelAccionesGBA({
    super.key,
    required this.onLucha,
    required this.onMochila,
    required this.onPokemon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white, width: 3),
      ),
      child: Row(
        children: [
          // IZQUIERDA
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: GbaButton(
                    label: "LUCHA",
                    color: const Color(0xFFB22222), // rojo
                    onTap: onLucha,
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: GbaButton(
                    label: "POKÉMON",
                    color: const Color(0xFFF4B400), // amarillo
                    onTap: onPokemon,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // DERECHA
          Expanded(
            child: GbaButton(
              label: "MOCHILA",
              color: const Color(0xFF1E90FF), // azul
              onTap: onMochila,
            ),
          ),
        ],
      ),
    );
  }
}
