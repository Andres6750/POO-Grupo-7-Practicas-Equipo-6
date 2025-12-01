// lib/ui/screens/pantalla_seleccion_equipo.dart

import 'package:flutter/material.dart';
import '../../controllers/manager.dart';
import '../../models/pokemon.dart';
import 'pantalla_torre.dart';

class PantallaSeleccionEquipo extends StatefulWidget {
  final String nombreJugador;

  const PantallaSeleccionEquipo({super.key, required this.nombreJugador});

  @override
  State<PantallaSeleccionEquipo> createState() =>
      _PantallaSeleccionEquipoState();
}

class _PantallaSeleccionEquipoState extends State<PantallaSeleccionEquipo> {
  final GameManager game = GameManager();

  late List<Pokemon> roster;
  final List<Pokemon> equipoSeleccionado = [];

  @override
  void initState() {
    super.initState();
    roster = game.roster30; // ← ahora usa el roster REAL generado en la partida
  }

  // Seleccionar / deselect
  void _toggleSeleccion(Pokemon p) {
    setState(() {
      if (equipoSeleccionado.contains(p)) {
        equipoSeleccionado.remove(p);
      } else {
        if (equipoSeleccionado.length < 6) {
          equipoSeleccionado.add(p);
        }
      }
    });
  }

Widget _buildPokemonCard(Pokemon p) {
  final seleccionado = equipoSeleccionado.contains(p);

  return GestureDetector(
    onTap: () => _toggleSeleccion(p),
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: seleccionado
            ? Colors.green.withOpacity(0.35)
            : Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: seleccionado ? Colors.green : Colors.black,
          width: seleccionado ? 3 : 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SPRITE
          Expanded(
            child: Transform.scale(
              scale: 1.6, // ← prueba 1.3, 1.5, 2.0
              child: Image.asset(
                "assets/sprites/${p.nombre.toLowerCase()}_front.gif",
                fit: BoxFit.contain,
                filterQuality: FilterQuality.none,
              ),
            ),
          ),


          const SizedBox(height: 6),

          // NOMBRE Y NIVEL
          Text(
            "${p.nombre}  Nv.${p.nivel}",
            style: const TextStyle(
              fontFamily: "PKMN",
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),

          // TIPO
          Text(
            "Tipo: ${p.tipoPrimario}",
            style: const TextStyle(
              fontFamily: "PKMN",
              fontSize: 13,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 6),

          // STATS
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "HP: ${p.hpMaximo}",
                style: const TextStyle(
                  fontFamily: "PKMN",
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Ataque: ${p.ataque}",
                style: const TextStyle(
                  fontFamily: "PKMN",
                  fontSize: 13,
                ),
              ),
              Text(
                "Defensa: ${p.defensa}",
                style: const TextStyle(
                  fontFamily: "PKMN",
                  fontSize: 13,
                ),
              ),
              Text(
                "Atq. Esp.: ${p.ataqueEspecial}",
                style: const TextStyle(
                  fontFamily: "PKMN",
                  fontSize: 13,
                ),
              ),
              Text(
                "Def. Esp.: ${p.defensaEspecial}",
                style: const TextStyle(
                  fontFamily: "PKMN",
                  fontSize: 13,
                ),
              ),
              Text(
                "Velocidad: ${p.velocidad}",
                style: const TextStyle(
                  fontFamily: "PKMN",
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}


  // Vista inferior del equipo elegido
  Widget _buildEquipoSeleccionado() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Equipo seleccionado:",
            style: TextStyle(
              fontFamily: "PKMN",
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: equipoSeleccionado.map((p) {
              return Column(
                children: [
                  SizedBox(
                    height: 40,
                    child: Image.asset(
                      "assets/sprites/${p.nombre.toLowerCase()}_front.gif",
                    ),
                  ),
                  Text(
                    p.nombre,
                    style: const TextStyle(
                      fontFamily: "PKMN",
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  )
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF83A4D4), Color(0xFF1B2838)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 16),
              const Text(
                "¡Selecciona tu equipo!",
                style: TextStyle(
                  fontFamily: "PKMN",
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double width = constraints.maxWidth;

                  // Cada tarjeta mide ~150px aprox.  
                  // Este cálculo decide cuántas caben por fila dinámicamente.
                  int columnas = (width / 150).floor();

                  if (columnas < 2) columnas = 2;
                  if (columnas > 6) columnas = 6;

                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columnas,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 0.72, // ajustado para evitar overflow
                    ),
                    itemCount: roster.length,
                    itemBuilder: (_, i) => _buildPokemonCard(roster[i]),
                  );
                },
              ),
            ),


              if (equipoSeleccionado.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: _buildEquipoSeleccionado(),
                ),

              const SizedBox(height: 10),

              GestureDetector(
                onTap: equipoSeleccionado.length == 6
                    ? () {
                        // Guardar en manager
                        game.equipoJugador =
                            equipoSeleccionado.map(_clonePokemon).toList();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PantallaTorre(
                              nombreJugador: widget.nombreJugador,
                              equipoJugador: game.equipoJugador,
                            ),
                          ),
                        );
                      }
                    : null,
                child: Container(
                  width: 260,
                  padding:
                      const EdgeInsets.symmetric(vertical: 14),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: equipoSeleccionado.length == 6
                        ? Colors.red
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Text(
                    equipoSeleccionado.length == 6
                        ? "Continuar"
                        : "Selecciona 6 Pokémon",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: "PKMN",
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Clonamos Pokémon SIN crear IVs nuevos
  Pokemon _clonePokemon(Pokemon p) {
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
}
