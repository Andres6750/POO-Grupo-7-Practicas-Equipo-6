// lib/ui/screens/pantalla_batalla.dart

import 'package:flutter/material.dart';
import '../../controllers/batalla.dart';
import '../../models/pokemon.dart';
import '../../utils/coloresTipos.dart';
import '../../audio/audio_manager.dart';

// Widgets
import '../widgets/spritePokemon.dart';
import '../widgets/cajaTextoGBA.dart';
import '../widgets/panelAccionesGBA.dart';
import '../widgets/pokemonHudGBA.dart';



class PantallaBatalla extends StatefulWidget {
  final List<Pokemon> equipoJugador;
  final List<Pokemon> equipoEnemigo;

  const PantallaBatalla({
    super.key,
    required this.equipoJugador,
    required this.equipoEnemigo,
  });

  @override
  State<PantallaBatalla> createState() => _PantallaBatallaState();
}

class _PantallaBatallaState extends State<PantallaBatalla> {
  late ControlBatalla batalla;

  String mensaje = "";

  double offsetJugador = 0;
  double offsetEnemigo = 0;

  double opacityJugador = 1;
  double opacityEnemigo = 1;

  bool shakeJugador = false;
  bool shakeEnemigo = false;

  bool _bloqueado = false;


  @override
  void initState() {
    super.initState();
    
    AudioManager().playRandomMusic([
      "champion.mp3",
      "cynthia.mp3",
      "gary.mp3",
      "magma.mp3",
      "toby.mp3",
    ]);

    batalla = ControlBatalla(
      equipoA: widget.equipoJugador,
      equipoB: widget.equipoEnemigo,
    );

    mensaje = "¿Qué debería hacer ${batalla.activoA.nombre}?";
  }

  EstadoAlterado _convertirEstado(String nombre) {
    switch (nombre) {
      case "paralizado":
        return EstadoAlterado.paralizado;
      case "quemado":
        return EstadoAlterado.quemado;
      case "envenenado":
        return EstadoAlterado.envenenado;
      case "congelado":
        return EstadoAlterado.congelado;
      default:
        return EstadoAlterado.ninguno;
    }
  }

  // =====================================================
  //                     ANIMACIONES
  // =====================================================

  Future<void> animAtaqueJugador() async {
    setState(() => offsetJugador = 40);
    await Future.delayed(const Duration(milliseconds: 140));
    setState(() => offsetJugador = 0);
  }

  Future<void> animAtaqueEnemigo() async {
    setState(() => offsetEnemigo = -40);
    await Future.delayed(const Duration(milliseconds: 140));
    setState(() => offsetEnemigo = 0);
  }

  Future<void> animDanoEnemigo() async {
    for (int i = 0; i < 3; i++) {
      setState(() {
        shakeEnemigo = true;
        opacityEnemigo = 0.3;
      });
      await Future.delayed(const Duration(milliseconds: 60));
      setState(() {
        shakeEnemigo = false;
        opacityEnemigo = 1;
      });
      await Future.delayed(const Duration(milliseconds: 60));
    }
  }

  Future<void> animDanoJugador() async {
    for (int i = 0; i < 3; i++) {
      setState(() {
        shakeJugador = true;
        opacityJugador = 0.3;
      });
      await Future.delayed(const Duration(milliseconds: 60));
      setState(() {
        shakeJugador = false;
        opacityJugador = 1;
      });
      await Future.delayed(const Duration(milliseconds: 60));
    }
  }

  Future<void> animParalizadoJugador() async {
    for (int i = 0; i < 2; i++) {
      setState(() => opacityJugador = 0.2);
      await Future.delayed(const Duration(milliseconds: 80));
      setState(() => opacityJugador = 1);
      await Future.delayed(const Duration(milliseconds: 80));
    }
  }

  Future<void> animParalizadoEnemigo() async {
    for (int i = 0; i < 2; i++) {
      setState(() => opacityEnemigo = 0.2);
      await Future.delayed(const Duration(milliseconds: 80));
      setState(() => opacityEnemigo = 1);
      await Future.delayed(const Duration(milliseconds: 80));
    }
  }

  Future<void> animFalloJugador() async {
    for (int i = 0; i < 2; i++) {
      setState(() => offsetJugador = -20);
      await Future.delayed(const Duration(milliseconds: 60));
      setState(() => offsetJugador = 0);
      await Future.delayed(const Duration(milliseconds: 60));
    }
  }

  Future<void> animFalloEnemigo() async {
    for (int i = 0; i < 2; i++) {
      setState(() => offsetEnemigo = 20);
      await Future.delayed(const Duration(milliseconds: 60));
      setState(() => offsetEnemigo = 0);
      await Future.delayed(const Duration(milliseconds: 60));
    }
  }

  Future<void> animKOJugador() async {
    setState(() {
      offsetJugador = 50;
      opacityJugador = 0;
    });
    await Future.delayed(const Duration(milliseconds: 600));
  }

  Future<void> animKOEnemigo() async {
    setState(() {
      offsetEnemigo = -50;
      opacityEnemigo = 0;
    });
    await Future.delayed(const Duration(milliseconds: 600));
  }

  Future<void> animEntradaJugador() async {
    setState(() {
      opacityJugador = 0;
      offsetJugador = 30;
    });
    await Future.delayed(const Duration(milliseconds: 120));
    setState(() {
      opacityJugador = 1;
      offsetJugador = 0;
    });
    await Future.delayed(const Duration(milliseconds: 120));
  }

  Future<void> animEntradaEnemigo() async {
    setState(() {
      opacityEnemigo = 0;
      offsetEnemigo = -30;
    });
    await Future.delayed(const Duration(milliseconds: 120));
    setState(() {
      opacityEnemigo = 1;
      offsetEnemigo = 0;
    });
    await Future.delayed(const Duration(milliseconds: 120));
  }

  // =====================================================
  //      APLICAR DAÑO EN LA UI + KO + CAMBIO AUTO
  // =====================================================

  /// Devuelve true si hubo KO (aunque no se acabe la batalla).
  Future<bool> _aplicarDanioYProcesarKO({
    required bool esAlJugador,
    required int danio,
  }) async {
    final poke = esAlJugador ? batalla.activoA : batalla.activoB;
    final hpAntes = poke.hpActual;

    poke.recibirDanio(danio);
    setState(() {});
    await Future.delayed(const Duration(milliseconds: 350));

    // Si no muere, seguimos normal
    if (hpAntes > 0 && !poke.estaDebilitado) return false;

    // Anim KO
    if (esAlJugador) {
      await animKOJugador();
    } else {
      await animKOEnemigo();
    }

    setState(() {
      mensaje = "${poke.nombre} fue debilitado!";
    });
    await Future.delayed(const Duration(milliseconds: 700));

    // ¿Se acabó el equipo?
    if (esAlJugador && batalla.jugadorDerrotado) {
      setState(() => mensaje = "¡Tu equipo fue derrotado!");
      return true;
    }
    if (!esAlJugador && batalla.enemigoDerrotado) {
      setState(() => mensaje = "¡El equipo enemigo fue derrotado!");
      return true;
    }

    // Cambio automático
    final nuevo = batalla.cambioAuto(esAlJugador);
    if (nuevo == null) return true;

    if (esAlJugador) {
      await animEntradaJugador();
      setState(() => mensaje = "¡Vas ${nuevo.nombre}!");
    } else {
      await animEntradaEnemigo();
      setState(() => mensaje = "Enemigo envía a ${nuevo.nombre}!");
    }

    await Future.delayed(const Duration(milliseconds: 700));
    return true;
  }

  // =====================================================
  //             EJECUTAR LA LISTA DE EVENTOS
  // =====================================================

  Future<void> _ejecutarEventos(List<EventoBatalla> eventos) async {
    for (final e in eventos) {
      switch (e.tipo) {
        case TipoEvento.texto:
          setState(() => mensaje = e.mensaje ?? "");
          await Future.delayed(const Duration(milliseconds: 1300));
          break;

        case TipoEvento.animAtaqueJugador:
          AudioManager().playFX("atacar.mp3");
          await animAtaqueJugador();
          await Future.delayed(const Duration(milliseconds: 250));
          break;

        case TipoEvento.animAtaqueEnemigo:
          AudioManager().playFX("atacar.mp3");
          await animAtaqueEnemigo();
          await Future.delayed(const Duration(milliseconds: 250));
          break;

        case TipoEvento.animDanoEnemigo:
          AudioManager().playFX("recibir.mp3");
          await animDanoEnemigo();
          await Future.delayed(const Duration(milliseconds: 400));
          break;

        case TipoEvento.animDanoJugador:
          AudioManager().playFX("recibir.mp3");
          await animDanoJugador();
          await Future.delayed(const Duration(milliseconds: 400));
          break;

        case TipoEvento.animFalloJugador:
          await animFalloJugador();
          await Future.delayed(const Duration(milliseconds: 400));
          break;

        case TipoEvento.animFalloEnemigo:
          await animFalloEnemigo();
          await Future.delayed(const Duration(milliseconds: 400));
          break;

        case TipoEvento.animParalizadoJugador:
          AudioManager().playFX("paralisis.mp3");
          await animParalizadoJugador();
          if (e.mensaje != null) {
            setState(() => mensaje = e.mensaje!);
            await Future.delayed(const Duration(milliseconds: 1200));
          }
          break;

        case TipoEvento.animParalizadoEnemigo:
          AudioManager().playFX("paralisis.mp3");
          await animParalizadoEnemigo();
          if (e.mensaje != null) {
            setState(() => mensaje = e.mensaje!);
            await Future.delayed(const Duration(milliseconds: 1200));
          }
          break;

        case TipoEvento.aplicarDanioJugador:
          final danioJ = int.tryParse(e.mensaje ?? "0") ?? 0;
          final koJ = await _aplicarDanioYProcesarKO(
            esAlJugador: true,
            danio: danioJ,
          );
          if (koJ) return;
          break;

        case TipoEvento.aplicarDanioEnemigo:
          final danioE = int.tryParse(e.mensaje ?? "0") ?? 0;
          final koE = await _aplicarDanioYProcesarKO(
            esAlJugador: false,
            danio: danioE,
          );
          if (koE) return;
          break;

        case TipoEvento.animEstadoJugador:
          await animParalizadoJugador();
          setState(() {});
          break;

        case TipoEvento.animEstadoEnemigo:
          await animParalizadoEnemigo();
          setState(() {});
          break;

        case TipoEvento.aplicarDanioEstadoJugador:
          break;

        case TipoEvento.aplicarDanioEstadoEnemigo:
          break;

        case TipoEvento.aplicarEstadoJugador:
          if (e.mensaje != null) {
            setState(() {
              batalla.activoA.estado = _convertirEstado(e.mensaje!);
            });
          }
          break;

        case TipoEvento.aplicarEstadoEnemigo:
          if (e.mensaje != null) {
            setState(() {
              batalla.activoB.estado = _convertirEstado(e.mensaje!);
            });
          }
          break;
        case TipoEvento.usarItemJugador:
          setState(() => mensaje = e.mensaje ?? "");
          await Future.delayed(const Duration(milliseconds: 900));
          break;

        case TipoEvento.aplicarEstadoCuradoJugador:
          setState(() => batalla.activoA.estado = EstadoAlterado.ninguno);
          await Future.delayed(const Duration(milliseconds: 400));
          break;

                case TipoEvento.aplicarCuracionJugador:
          final monto = int.tryParse(e.mensaje ?? "0") ?? 0;
          setState(() {
            batalla.activoA.curar(monto);
          });
          await Future.delayed(const Duration(milliseconds: 400));
          break;

        case TipoEvento.aplicarDescongeladoJugador:
          setState(() => batalla.activoA.estado = EstadoAlterado.ninguno);
          if (e.mensaje != null) mensaje = e.mensaje!;
          await Future.delayed(const Duration(milliseconds: 900));
          break;

        case TipoEvento.aplicarDescongeladoEnemigo:
          setState(() => batalla.activoB.estado = EstadoAlterado.ninguno);
          if (e.mensaje != null) mensaje = e.mensaje!;
          await Future.delayed(const Duration(milliseconds: 900));
          break;


      }
    }
  }

  // =====================================================
  //                ATAQUE DEL JUGADOR
  // =====================================================

      void ejecutarMovimiento(int index) async {
    if (_bloqueado) return;
    if (batalla.jugadorDerrotado || batalla.enemigoDerrotado) return;

    setState(() {
      _bloqueado = true;
      mensaje = "";
    });
    await Future.delayed(const Duration(milliseconds: 200));

    final resultado = batalla.resolverTurno(index);
    await _ejecutarEventos(resultado.eventos);

    if (batalla.enemigoDerrotado) {
      setState(() => mensaje = "¡El equipo enemigo fue derrotado!");
      await Future.delayed(const Duration(milliseconds: 1200));

      await AudioManager().stopMusic();
      Navigator.pop(context, "victoria");  
       
      return;
    }


    if (batalla.jugadorDerrotado) {
      setState(() => mensaje = "¡Tu equipo fue derrotado!");
      await Future.delayed(const Duration(milliseconds: 1200));

      await AudioManager().stopMusic();
      Navigator.pop(context, "derrota");
      return;
    }


    setState(() {
      mensaje = "¿Qué debería hacer ${batalla.activoA.nombre}?";
      _bloqueado = false;
    });
  }



  // =====================================================
  //           CAMBIO MANUAL DE POKÉMON DEL JUGADOR
  // =====================================================

  void cambiarPokemon(int index) async {
    if (_bloqueado) return;

    final texto = batalla.jugadorCambia(index);
    setState(() {
      _bloqueado = true;
      mensaje = texto;
    });

    await animEntradaJugador();
    setState(() {
      _bloqueado = false;
    });
  }


    void _usarItem(int index) async {
    if (_bloqueado) return;
    if (index < 0 || index >= batalla.mochila.length) return;

    setState(() => _bloqueado = true);

    final item = batalla.mochila[index];
    final resultado = batalla.usarItemSobreJugador(item, index);

    await _ejecutarEventos(resultado.eventos);

    setState(() {
      mensaje = "¿Qué debería hacer ${batalla.activoA.nombre}?";
      _bloqueado = false;
    });
  }


  // =====================================================
  //                         UI
  // =====================================================

  @override
  Widget build(BuildContext context) {
    final yo = batalla.activoA;
    final rival = batalla.activoB;

    final double altoPanelInferior =
        MediaQuery.of(context).size.height * 0.25;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF83A4D4), Color(0xFF1B2838)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            children: [

              // ================= ENEMIGO =================
              Positioned(
                top: 40,
                right: 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: PokemonHudGBA(
                        pokemon: rival,
                        esEnemigo: true,
                      ),
                    ),

                    const SizedBox(height: 10),

                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 120),
                      opacity: opacityEnemigo,
                      child: Transform.translate(
                        offset: Offset(
                          offsetEnemigo + (shakeEnemigo ? 8 : 0),
                          20,
                        ),
                        child: SpritePokemon(
                          path:
                              "assets/sprites/${rival.nombre.toLowerCase()}_front.gif",
                          scale: 2.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ================= JUGADOR =================
              Positioned(
                bottom: altoPanelInferior + 20,
                left: 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 120),
                      opacity: opacityJugador,
                      child: Transform.translate(
                        offset: Offset(
                          offsetJugador + (shakeJugador ? -8 : 0),
                          -30,
                        ),
                        child: SpritePokemon(
                          path:
                              "assets/sprites/${yo.nombre.toLowerCase()}_back.gif",
                          scale: 2.1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: PokemonHudGBA(
                        pokemon: yo,
                        esEnemigo: false,
                      ),
                    ),
                  ],
                ),
              ),

              // ================= MENSAJES =================
              Positioned(
                left: 10,
                bottom: 10,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.60,
                  height: altoPanelInferior,
                  child: GbaTextBox(text: mensaje),
                ),
              ),

              // ================= PANEL ACCIONES =================
              Positioned(
                right: 10,
                bottom: 10,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.40,
                  height: altoPanelInferior,
                  child: PanelAccionesGBA(
                    onLucha: _mostrarMenuMovimientos,
                    onMochila: _mostrarMenuMochila,
                    onPokemon: _mostrarMenuCambio,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =====================================================
  //                MENÚ MOVIMIENTOS
  // =====================================================

  void _mostrarMenuMovimientos() {
    if (_bloqueado) return;
    final movs = batalla.activoA.movimientos;

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.white, width: 3),
          ),
          title: const Text(
            "Elige un movimiento",
            style: TextStyle(
              fontFamily: "PKMN",
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: movs.asMap().entries.map((e) {
              final index = e.key;
              final mov = e.value;

              final tipoColor =
                  colorTipo[mov.tipo] ?? const Color(0xFF444444);

              return Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tipoColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(ctx);
                    ejecutarMovimiento(index);
                  },
                  child: Text(
                    mov.nombre,
                    style: const TextStyle(
                      fontFamily: "PKMN",
                      fontSize: 20,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _mostrarMenuMochila() {
  if (_bloqueado) return;
  final items = batalla.mochila;

  showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        backgroundColor: Colors.black,
        title: const Text("Mochila",
            style: TextStyle(fontFamily: "PKMN", color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: items.asMap().entries.map((e) {
            final index = e.key;
            final item = e.value;

            return Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  _usarItem(index);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  "${item.nombre} x${item.cantidad}",
                  style: const TextStyle(fontFamily: "PKMN", fontSize: 20),
                ),
              ),
            );
          }).toList(),
        ),
      );
    },
  );
}

  // =====================================================
  //                MENÚ CAMBIO POKÉMON
  // =====================================================

  void _mostrarMenuCambio() {
    if (_bloqueado) return;
    final equipo = batalla.equipoA;

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: const Color(0xFF101010),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.white, width: 3),
            borderRadius: BorderRadius.circular(6),
          ),
          title: const Text(
            "Elige un Pokémon",
            style: TextStyle(
              fontFamily: "PKMN",
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: equipo.asMap().entries.map((e) {
              final index = e.key;
              final p = e.value;
              final debilitado = p.estaDebilitado;

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: debilitado
                      ? null
                      : () {
                          Navigator.pop(ctx);
                          cambiarPokemon(index);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: debilitado
                        ? Colors.grey[700]
                        : const Color(0xFF2C2C2C),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                      side: const BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  child: Text(
                    "${p.nombre}  HP:${p.hpActual}/${p.hpMaximo}",
                    style: const TextStyle(
                      fontFamily: "PKMN",
                      fontSize: 18,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
