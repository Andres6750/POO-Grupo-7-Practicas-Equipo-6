import 'package:flutter/material.dart';

class GbaTextBox extends StatelessWidget {
  final String text;

  const GbaTextBox({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6), // semitransparente
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.white, width: 3),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: "PKMN",
          fontSize: 23,
          color: Colors.white,
          height: 1.3,
        ),
      ),
    );
  }
}
