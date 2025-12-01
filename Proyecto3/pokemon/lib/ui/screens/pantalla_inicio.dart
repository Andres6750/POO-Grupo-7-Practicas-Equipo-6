// lib/ui/screens/pantalla_inicio.dart

import 'package:flutter/material.dart';
import '../../audio/audio_manager.dart';
import 'pantalla_nombre.dart';
import 'pantalla_opciones.dart';


class PantallaInicio extends StatefulWidget {
  const PantallaInicio({super.key});

  @override
  State<PantallaInicio> createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();

    AudioManager().playMusic("musica_intro.mp3");


    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _scaleAnim = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  static const Color bordeRojo = Color(0xFFB80000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo
          Positioned.fill(
            child: Image.asset(
              "assets/backgrounds/fondoInicio.png",
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: Center(
              child: FadeTransition(
                opacity: _fadeAnim,
                child: ScaleTransition(
                  scale: _scaleAnim,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo
                      SizedBox(
                        width: 360,
                        child: Image.asset(
                          "assets/logos/pokemon.png",
                          fit: BoxFit.contain,
                        ),
                      ),

                      const SizedBox(height: 60),

                      // NUEVA PARTIDA
                      _buildButton(
                        label: "Nueva Partida",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PantallaNombre(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 20),


                      _buildButton(
                        label: "Opciones",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PantallaOpciones(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
  required String label,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Container(
      width: 260,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: bordeRojo, width: 4),
        boxShadow: const [
          BoxShadow(
            color: Colors.black87,
            offset: Offset(3, 3),
            blurRadius: 5,
          )
        ],
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: "PKMN",
          fontSize: 22,
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

}
