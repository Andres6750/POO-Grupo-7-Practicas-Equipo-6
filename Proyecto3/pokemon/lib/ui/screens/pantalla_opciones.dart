import 'package:flutter/material.dart';
import '../../audio/audio_manager.dart';

class PantallaOpciones extends StatefulWidget {
  const PantallaOpciones({super.key});

  @override
  State<PantallaOpciones> createState() => _PantallaOpcionesState();
}

class _PantallaOpcionesState extends State<PantallaOpciones> {
  double volumen = AudioManager().musicVolume;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B2838),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Opciones",
          style: TextStyle(
            fontFamily: "PKMN",
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Volumen de Música",
              style: TextStyle(
                fontFamily: "PKMN",
                fontSize: 22,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 30),

            Slider(
              value: volumen,
              min: 0,
              max: 1,
              divisions: 10,
              activeColor: Colors.redAccent,
              inactiveColor: Colors.white24,
              onChanged: (v) {
                setState(() => volumen = v);
                AudioManager().setVolume(v);
              },
            ),

            const SizedBox(height: 40),

            Text(
              "${(volumen * 100).round()}%",
              style: const TextStyle(
                fontFamily: "PKMN",
                fontSize: 26,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
