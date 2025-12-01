// lib/ui/screens/pantalla_torre.dart

import 'dart:math';
import 'package:flutter/material.dart';

import '../../models/pokemon.dart';
import '../../models/item.dart';
import '../../controllers/manager.dart';
import '../../audio/audio_manager.dart';
import '../../data/entrenadores.dart';

import 'pantalla_vs.dart';
import 'pantalla_victoria.dart';
import 'pantalla_derrota.dart';

class PantallaTorre extends StatefulWidget {
  final String nombreJugador;
  final List<Pokemon> equipoJugador;

  const PantallaTorre({
    super.key,
    required this.nombreJugador,
    required this.equipoJugador,
  });

  @override
  State<PantallaTorre> createState() => _PantallaTorreState();
}

class _PantallaTorreState extends State<PantallaTorre> {
  late List<EntrenadorData> torre;
  int indiceActual = 0;

  final List<EntrenadorData> amigos = [
    entrenadorAbdiel,
    entrenadorAlan,
    entrenadorRoberto,
    entrenadorOswaldo,
    entrenadorAndres,
  ];

  final List<EntrenadorData> campeones = [
    entrenadorAsh,
    entrenadorRojo,
    entrenadorEthan,
    entrenadorSinnoh,
  ];

  @override
  void initState() {
    super.initState();

    // 1. Mezclamos amigos (serán los 5 primeros)
    final listaAmigos = List<EntrenadorData>.from(amigos)..shuffle();

    // 2. Elegimos campeón aleatorio
    final campeonRandom = campeones[Random().nextInt(campeones.length)];

    // 3. Torre completa: 5 amigos + 1 campeón
    torre = [...listaAmigos, campeonRandom];
  }

  // ============================================================
  //             GRID REALMENTE ADAPTATIVO (1–4 columnas)
  // ============================================================
  Widget _buildEquipoAdaptive(List<Pokemon> equipo) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;

        const double itemWidth = 150;
        int columns = (maxWidth / itemWidth).floor().clamp(1, 4);

        double actualWidth = maxWidth / columns;

        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: equipo.map((p) {
            return SizedBox(
              width: actualWidth,
              child: Row(
                children: [
                  Image.asset(
                    "assets/sprites/${p.nombre.toLowerCase()}_front.gif",
                    width: 40,
                    height: 40,
                    filterQuality: FilterQuality.none,
                    isAntiAlias: false,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    p.nombre,
                    style: const TextStyle(
                      fontFamily: "PKMN",
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }

  // Clonar Pokémon sin alterar IVs
  Pokemon clonar(Pokemon p) {
    return Pokemon(
      nombre: p.nombre,
      tipoPrimario: p.tipoPrimario,
      baseHP: p.baseHP,
      baseAtk: p.baseAtk,
      baseDef: p.baseDef,
      baseSpAtk: p.baseSpAtk,
      baseSpDef: p.baseSpDef,
      baseSpeed: p.baseSpeed,
      nivel: p.nivel,
      movimientos: List.from(p.movimientos),
    );
  }

  @override
  Widget build(BuildContext context) {
    final entrenador = torre[indiceActual];
    // Copia profunda + mezcla para que el primer Pokémon nunca sea el mismo
    final equipoEnemigo = List<Pokemon>.from(entrenador.equipo)..shuffle();
    final equipoEnemigoClonado = equipoEnemigo.map(clonar).toList();


    return Scaffold(
      backgroundColor: const Color(0xFF1B2838),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  const Text(
                    "TORRE DE ENTRENADORES",
                    style: TextStyle(
                      fontFamily: "PKMN",
                      fontSize: 28,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // TARJETA ENTRENADOR
                  Container(
                    padding: const EdgeInsets.all(18),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C3545),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Entrenador: ${entrenador.nombre}",
                          style: const TextStyle(
                            fontFamily: "PKMN",
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),

                        SizedBox(
                          height: 260,
                          child: Center(
                            child: Transform.scale(
                              scale: 3.0,
                              child: Image.asset(
                                "assets/trainers/${entrenador.sprite}",
                                filterQuality: FilterQuality.none,
                                isAntiAlias: false,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                        const Text(
                          "Equipo:",
                          style: TextStyle(
                            fontFamily: "PKMN",
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),

                        _buildEquipoAdaptive(equipoEnemigoClonado),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  const Text(
                    "Tu equipo:",
                    style: TextStyle(
                      fontFamily: "PKMN",
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 10),
                  _buildEquipoAdaptive(widget.equipoJugador),

                  const SizedBox(height: 40),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 40,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                    onPressed: () async {
                      // Cortar música actual (intro / torre) con fade
                      await AudioManager().fadeOut();

                      final gm = GameManager();

                      final resultado = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PantallaVS(
                            nombreJugador: widget.nombreJugador,
                            spriteJugador: gm.spriteEntrenador,
                            entrenadorRival: entrenador,
                            equipoJugador: widget.equipoJugador,
                            equipoEnemigo: equipoEnemigoClonado,
                          ),
                        ),
                      );

                      if (resultado == "victoria") {
                        _procesarVictoria();
                      } else if (resultado == "derrota") {
                        _mostrarDerrotaFinal();
                      }
                    },
                    child: const Text(
                      "¡COMBATIR!",
                      style: TextStyle(
                        fontFamily: "PKMN",
                        fontSize: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  //               PROCESO DE VICTORIA / DERROTA
  // ============================================================

  void _procesarVictoria() {
    // 1. Curar todo el equipo
    for (final p in widget.equipoJugador) {
      p.curarAlMaximo();
      p.estado = EstadoAlterado.ninguno;
    }

    // 2. Recompensa de 3 ítems aleatorios
    final gm = GameManager();
    final rnd = Random();

    final itemsPool = gm.generarItemsFacil();

    for (int i = 0; i < 3; i++) {
      final base = itemsPool[rnd.nextInt(itemsPool.length)];

      gm.itemsJugador.add(
        Item(
          nombre: base.nombre,
          tipo: base.tipo,
          cantidad: 1,
          montoHP: base.montoHP,
          cura: base.cura,
        ),
      );
    }

    // 3. Avanzar de piso
    setState(() => indiceActual++);

    if (indiceActual >= 6) {
      _mostrarVictoriaFinal();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "¡Has vencido a ${torre[indiceActual - 1].nombre}! "
            "Tu equipo fue curado y recibiste 3 ítems.",
          ),
        ),
      );
    }
  }

void _mostrarDerrotaFinal() async {
  await AudioManager().fadeOut();

  await AudioManager().fadeOut();
  AudioManager().playMusic("derrota.mp3");
  final gm = GameManager();

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => PantallaDerrota(
        nombreJugador: widget.nombreJugador,
        spriteJugador: gm.spriteEntrenador,
      ),
    ),
  );
}

  void _mostrarVictoriaFinal() async {
    // Cortar música de batalla y poner fanfarria
    await AudioManager().fadeOut();
    final gm = GameManager();

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => PantallaVictoria(
          nombreJugador: widget.nombreJugador,
          spriteJugador: gm.spriteEntrenador,
        ),
      ),
    );
  }
}
