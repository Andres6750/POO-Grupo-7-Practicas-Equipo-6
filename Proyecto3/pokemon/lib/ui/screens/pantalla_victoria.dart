// lib/ui/screens/pantalla_victoria.dart

import 'package:flutter/material.dart';
import '../../audio/audio_manager.dart';

class PantallaVictoria extends StatefulWidget {
  final String nombreJugador;
  final String spriteJugador;

  const PantallaVictoria({
    super.key,
    required this.nombreJugador,
    required this.spriteJugador,
  });

  @override
  State<PantallaVictoria> createState() => _PantallaVictoriaState();
}

class _PantallaVictoriaState extends State<PantallaVictoria>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _opacityAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _scaleAnim = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _opacityAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    AudioManager().stopMusic();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      body: SafeArea(
        child: Center(
          child: FadeTransition(
            opacity: _opacityAnim,
            child: ScaleTransition(
              scale: _scaleAnim,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1D4ED8), Color(0xFF7C3AED)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "¡FELICIDADES!",
                        style: TextStyle(
                          fontFamily: "PKMN",
                          fontSize: 26,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),

                      SizedBox(
                        height: 160,
                        child: Image.asset(
                          "assets/trainers/${widget.spriteJugador}.png",
                          filterQuality: FilterQuality.none,
                          isAntiAlias: false,
                        ),
                      ),


                      const SizedBox(height: 12),
                      Text(
                        widget.nombreJugador,
                        style: const TextStyle(
                          fontFamily: "PKMN",
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "¡Eres el Campeón de la Torre FI!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "PKMN",
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 24),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black87,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 32,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(color: Colors.white, width: 2),
                          ),
                        ),
                        onPressed: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        child: const Text(
                          "Volver al inicio",
                          style: TextStyle(
                            fontFamily: "PKMN",
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
