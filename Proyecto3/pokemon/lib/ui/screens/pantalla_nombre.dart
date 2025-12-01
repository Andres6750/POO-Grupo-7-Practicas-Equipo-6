// lib/ui/screens/pantalla_nombre.dart

import 'package:flutter/material.dart';
import '../../controllers/manager.dart';
import 'pantalla_seleccion.dart';

class PantallaNombre extends StatefulWidget {
  const PantallaNombre({super.key});

  @override
  State<PantallaNombre> createState() => _PantallaNombreState();
}

class _PantallaNombreState extends State<PantallaNombre> {
  final TextEditingController _ctrl = TextEditingController();

  String seleccionado = "hombre";

  String dificultad = "facil"; 

    Widget _buildDiffButton(String label, String value) {
    final activo = dificultad == value;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => dificultad = value);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: activo ? Colors.redAccent : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: activo ? Colors.white : Colors.grey,
              width: 2,
            ),
          ),
          child: Text(
            label.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: "PKMN",
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTrainerCard(String tipo) {
  final bool activo = seleccionado == tipo;

  return GestureDetector(
    onTap: () {
      setState(() => seleccionado = tipo);
    },
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.transparent, // ← SIN FONDO
        borderRadius: BorderRadius.circular(12),

        // Borde rojo cuando está seleccionado, blanco cuando no
        border: Border.all(
          color: activo ? Colors.red : Colors.white,
          width: activo ? 3 : 2,
        ),

        // "Glow" rojo leve para selección (muy visual)
        boxShadow: activo
            ? [
                BoxShadow(
                  color: Colors.red.withOpacity(0.6),
                  blurRadius: 12,
                  spreadRadius: 1,
                )
              ]
            : [],
      ),
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              "assets/trainers/${tipo}.png",
              fit: BoxFit.contain,

              // 🔥 Pixel perfect
              filterQuality: FilterQuality.none,
              isAntiAlias: false,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            tipo == "hombre" ? "Entrenador" : "Entrenadora",
            style: const TextStyle(
              fontFamily: "PKMN",
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "¿Cuál es tu nombre?",
                style: TextStyle(
                  fontFamily: "PKMN",
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: _ctrl,
                style: const TextStyle(
                  fontFamily: "PKMN",
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  hintText: "Tu nombre",
                  hintStyle: TextStyle(
                    fontFamily: "PKMN",
                    color: Colors.white54,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent)),
                ),
              ),

              const SizedBox(height: 35),

  

              const SizedBox(height: 20),

              const Text(
                "Dificultad",
                style: TextStyle(
                  fontFamily: "PKMN",
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  _buildDiffButton("fácil", "facil"),
                  const SizedBox(width: 12),
                  _buildDiffButton("medio", "medio"),
                  const SizedBox(width: 12),
                  _buildDiffButton("difícil", "dificil"),
                ],
              ),

              const SizedBox(height: 25),

              const Text(
                "Selecciona tu entrenador",
                style: TextStyle(
                  fontFamily: "PKMN",
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),

              Expanded(
                child: Row(
                  children: [
                    Expanded(child: _buildTrainerCard("hombre")),
                    const SizedBox(width: 20),
                    Expanded(child: _buildTrainerCard("mujer")),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              GestureDetector(
                onTap: () async {
                  if (_ctrl.text.isEmpty) return;

                  final game = GameManager();
                  await game.nuevaPartida(_ctrl.text, seleccionado, dificultad);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PantallaSeleccionEquipo(
                        nombreJugador: game.jugadorNombre,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 260,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Text(
                    "Continuar",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "PKMN",
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
