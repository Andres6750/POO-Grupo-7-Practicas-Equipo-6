// lib/ui/screens/pantalla_vs.dart

import 'package:flutter/material.dart';

import '../../audio/audio_manager.dart';
import '../../models/pokemon.dart';
import '../../data/entrenadores.dart';
import 'pantalla_batalla.dart';

class PantallaVS extends StatefulWidget {
  final String nombreJugador;
  final String spriteJugador; 
  final EntrenadorData entrenadorRival;
  final List<Pokemon> equipoJugador;
  final List<Pokemon> equipoEnemigo;

  const PantallaVS({
    super.key,
    required this.nombreJugador,
    required this.spriteJugador,
    required this.entrenadorRival,
    required this.equipoJugador,
    required this.equipoEnemigo,
  });

  @override
  State<PantallaVS> createState() => _PantallaVSState();
}

class _PantallaVSState extends State<PantallaVS>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  bool _yaEmpezoBatalla = false;

  @override
  void initState() {
    super.initState();

    AudioManager().playMusic("vs.mp3");

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _scaleAnim = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();

    Future.delayed(const Duration(milliseconds: 1200), _irABatalla);
  }

  Future<void> _irABatalla() async {
    if (_yaEmpezoBatalla || !mounted) return;
    _yaEmpezoBatalla = true;

    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PantallaBatalla(
          equipoJugador: widget.equipoJugador,
          equipoEnemigo: widget.equipoEnemigo,
        ),
      ),
    );

    if (!mounted) return;
    Navigator.pop(context, resultado);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rival = widget.entrenadorRival;

    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: SafeArea(
        child: Center(
          child: ScaleTransition(
            scale: _scaleAnim,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF111827), Color(0xFF1F2937)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(color: Colors.white, width: 3),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // JUGADOR
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 120,
                        child: Image.asset(
                          "assets/trainers/${widget.spriteJugador}.png",
                          filterQuality: FilterQuality.none,
                          isAntiAlias: false,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.nombreJugador,
                        style: const TextStyle(
                          fontFamily: "PKMN",
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(width: 16),

                  const Text(
                    "VS",
                    style: TextStyle(
                      fontFamily: "PKMN",
                      fontSize: 32,
                      color: Colors.redAccent,
                    ),
                  ),

                  const SizedBox(width: 16),

                  // RIVAL
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 120,
                        child: Image.asset(
                          "assets/trainers/${rival.sprite}",
                          filterQuality: FilterQuality.none,
                          isAntiAlias: false,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        rival.nombre,
                        style: const TextStyle(
                          fontFamily: "PKMN",
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
