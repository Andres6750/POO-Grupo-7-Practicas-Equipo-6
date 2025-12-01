import 'package:flutter/material.dart';

class BarraVida extends StatelessWidget {
  final int hpActual;
  final int hpMax;

  const BarraVida({
    super.key,
    required this.hpActual,
    required this.hpMax,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final width = constraints.maxWidth;
        final porcentaje = hpActual / hpMax;

        return TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          tween: Tween<double>(
            begin: 0,
            end: porcentaje,
          ),
          builder: (_, value, __) {
            return Stack(
              children: [
                Container(
                  width: width,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color.fromARGB(255, 255, 255, 255), width: 2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),

                // Barra animada
                Container(
                  width: width * value,
                  height: 12,
                  decoration: BoxDecoration(
                    color: _colorHP(porcentaje),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Color _colorHP(double p) {
    if (p > 0.5) return Colors.green;
    if (p > 0.2) return Colors.yellow;
    return Colors.red;
  }
}
