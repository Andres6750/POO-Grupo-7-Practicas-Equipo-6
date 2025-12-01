// lib/ui/widgets/gba_button.dart

import 'package:flutter/material.dart';

class GbaButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final Color color;

  const GbaButton({
    super.key,
    required this.label,
    required this.onTap,
    required this.color,
  });

  @override
  State<GbaButton> createState() => _GbaButtonState();
}

class _GbaButtonState extends State<GbaButton> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => pressed = true),
      onTapUp: (_) {
        setState(() => pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: EdgeInsets.symmetric(
          vertical: pressed ? 10 : 14,
        ),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.white,
            width: 3,
          ),
          boxShadow: pressed
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    offset: const Offset(3, 3),
                    blurRadius: 0,
                  ),
                ],
        ),
        child: Center(
          child: Text(
            widget.label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: "PKMN",
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
