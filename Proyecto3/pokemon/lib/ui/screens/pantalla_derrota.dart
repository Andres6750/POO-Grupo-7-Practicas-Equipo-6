// lib/ui/screens/pantalla_derrota.dart

import 'package:flutter/material.dart';
import '../../audio/audio_manager.dart';

class PantallaDerrota extends StatefulWidget {
  final String nombreJugador;
  final String spriteJugador;

  const PantallaDerrota({
    super.key,
    required this.nombreJugador,
    required this.spriteJugador,
  });

  @override
  State<PantallaDerrota> createState() => _PantallaDerrotaState();
}

class _PantallaDerrotaState extends State<PantallaDerrota>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();

    AudioManager().playMusic("derrota.mp3", loop: true);

    // Animaciones
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _opacityAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnim = Tween<double>(begin: 0.6, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
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
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: FadeTransition(
            opacity: _opacityAnim,
            child: ScaleTransition(
              scale: _scaleAnim,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF3A0000), Color(0xFF000000)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.redAccent, width: 3),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "¡HAS SIDO DERROTADO!",
                        style: TextStyle(
                          fontFamily: "PKMN",
                          fontSize: 26,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // 🎮 Sprite del jugador derrotado
                      SizedBox(
                        height: 160,
                        child: Image.asset(
                          "assets/trainers/${widget.spriteJugador}.png",
                          filterQuality: FilterQuality.none,
                          isAntiAlias: false,
                        ),
                      ),

                      const SizedBox(height: 20),
                      const Text(
                        "Tu aventura termina aquí...",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "PKMN",
                          fontSize: 18,
                          color: Colors.white70,
                        ),
                      ),

                      const SizedBox(height: 25),

                      Text(
                        widget.nombreJugador,
                        style: const TextStyle(
                          fontFamily: "PKMN",
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 30),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent.shade700,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 30,
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
                          style: TextStyle(fontFamily: "PKMN", fontSize: 18),
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
