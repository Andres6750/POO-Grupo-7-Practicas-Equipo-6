// =========================================================
//  MODELOS Y UTILIDADES NECESARIAS PARA LA BATALLA
// =========================================================
//
// Se importan las clases esenciales para que el controlador
// pueda manipular Pokémon, movimientos, ítems y utilidades
// como la tabla de tipos o el GameManager.


import 'dart:math';
import '../models/pokemon.dart';
import '../models/movimiento.dart';
import '../utils/tablaDeTipos.dart';
import '../models/item.dart';
import '../utils/itemsBasicos.dart';
import 'manager.dart';


// =========================================================
//  ENUMERACIÓN DE EVENTOS QUE LA INTERFAZ RECIBIRÁ
// =========================================================
//
// Un EventoBatalla es un mensaje que el controlador manda
// a la UI para que sepa qué animación hacer, qué texto
// mostrar, qué daño aplicar, etc.
// No modifica el estado internamente: la UI se encarga de ello.

enum TipoEvento {
  texto,

  //Animacioón de ataque
  animAtaqueJugador,
  animAtaqueEnemigo,

  //Animación de recibir daño
  animDanoJugador,
  animDanoEnemigo,

  //Animación de fallar ataque
  animFalloJugador,
  animFalloEnemigo,

  //Animación de paralizado
  animParalizadoJugador,
  animParalizadoEnemigo,

  //Animación de estado
  animEstadoJugador,
  animEstadoEnemigo,

  //AEvento de aplicar daño al jugador
  aplicarDanioJugador,
  aplicarDanioEnemigo,

  //Evento de aplicar daño por estado 
  aplicarDanioEstadoJugador,
  aplicarDanioEstadoEnemigo,

  //Aplicar un estado al jugador
  aplicarEstadoJugador,
  aplicarEstadoEnemigo,

  aplicarDescongeladoJugador,
  aplicarDescongeladoEnemigo,

  //Usar item
  usarItemJugador,

  //Curar estado con item
  aplicarEstadoCuradoJugador,

  //Curar vida con item
  aplicarCuracionJugador,
}


// =========================================================
//  EVENTO INDIVIDUAL
// =========================================================
//
// Cada evento tiene un tipo y un posible mensaje de texto.
// La UI los procesará en orden.
//

class EventoBatalla {
  final TipoEvento tipo;

  //El ? indica que esta variable peude ser nula (no hay mensaje)
  final String? mensaje;
  
  //Constructor
  EventoBatalla(this.tipo, {this.mensaje});
}

// =========================================================
//  RESULTADO DEL TURNO COMPLETO
// =========================================================
//
// Cuando se llama a resolverTurno, se devuelve una lista
// completa de eventos que la UI deberá ejecutar secuencialmente.
//

class ResultadoTurno {
  final List<EventoBatalla> eventos;
  ResultadoTurno({required this.eventos});
}


// =========================================================
//                 CONTROLADOR DE BATALLA
// =========================================================
//
// Aquí se maneja toda la lógica del combate: orden,
// movimientos, cálculo de daño, estados, ítems, cambios, etc.
//

class ControlBatalla {
  final List<Pokemon> equipoA;
  final List<Pokemon> equipoB;

  late Pokemon activoA;
  late Pokemon activoB;

  final Random _rng = Random();

  List<Item> mochila = [];

  ControlBatalla({
    required this.equipoA,
    required this.equipoB,
  }) {
    activoA = equipoA.first;
    activoB = equipoB.first;

    // Se toma la mochila del GameManager si existe.
    final gm = GameManager();
    mochila = gm.itemsJugador.isNotEmpty ? gm.itemsJugador : mochilaInicial;
  }

  // Estados globales
  bool get jugadorDerrotado => equipoA.every((p) => p.estaDebilitado);
  bool get enemigoDerrotado => equipoB.every((p) => p.estaDebilitado);


  // =========================================================
  //                     RESOLVER TURNO
  // =========================================================
  //
  // Recibe el índice del movimiento elegido por el jugador.
  // Selecciona uno aleatorio del enemigo.
  // Decide quién va primero.
  // Ejecuta ambos ataques y los efectos de fin de turno.
  //

  ResultadoTurno resolverTurno(int idxMovJugador) {
    final ev = <EventoBatalla>[];

    // Si la batalla ya terminó, no hacer nada.
    if (jugadorDerrotado || enemigoDerrotado) {
      ev.add(EventoBatalla(TipoEvento.texto,
          mensaje: "La batalla ya terminó."));
      return ResultadoTurno(eventos: ev);
    }

    // Validar índice del movimiento
    final movsJugador = activoA.movimientos;
    if (idxMovJugador < 0 || idxMovJugador >= movsJugador.length) {
      ev.add(EventoBatalla(TipoEvento.texto,
          mensaje: "Movimiento inválido."));
      return ResultadoTurno(eventos: ev);
    }

    final movJ = movsJugador[idxMovJugador];
    final movE = activoB.movimientos[_rng.nextInt(activoB.movimientos.length)];

    final jugadorPrimero = _decidirOrden(movJ, activoA, movE, activoB);

    // Orden de ejecución
    if (jugadorPrimero) {
      ev.addAll(_eventosAtaque(
        atacante: activoA,
        defensor: activoB,
        movimiento: movJ,
        esJugador: true,
      ));

      ev.addAll(_eventosAtaque(
        atacante: activoB,
        defensor: activoA,
        movimiento: movE,
        esJugador: false,
      ));
    } else {
      ev.addAll(_eventosAtaque(
        atacante: activoB,
        defensor: activoA,
        movimiento: movE,
        esJugador: false,
      ));

      ev.addAll(_eventosAtaque(
        atacante: activoA,
        defensor: activoB,
        movimiento: movJ,
        esJugador: true,
      ));
    }

    // Efectos de fin de turno (veneno, quemadura, etc.)
    ev.addAll(_eventosFinDeTurno(activoA, true));
    ev.addAll(_eventosFinDeTurno(activoB, false));

    return ResultadoTurno(eventos: ev);
  }


  // =========================================================
  //               EVENTOS GENERADOS POR UN ATAQUE
  // =========================================================

  List<EventoBatalla> _eventosAtaque({
    required Pokemon atacante,
    required Pokemon defensor,
    required Movimiento movimiento,
    required bool esJugador,
  }) {
    final ev = <EventoBatalla>[];

    // Posible bloqueo por estado (parálisis, congelado)
    final bloqueo = _bloqueoEstado(atacante, esJugador);
    if (bloqueo != null) {
      ev.add(bloqueo);
      return ev;
    }

    // Animación de ataque
    ev.add(EventoBatalla(
      esJugador ? TipoEvento.animAtaqueJugador : TipoEvento.animAtaqueEnemigo,
    ));

    // Texto "X usa Y"
    ev.add(EventoBatalla(
      TipoEvento.texto,
      mensaje: "${atacante.nombre} usa ${movimiento.nombre}!",
    ));

    // Fallo del ataque
    if (_rng.nextInt(100) + 1 > movimiento.precision) {
      ev.add(EventoBatalla(
        esJugador ? TipoEvento.animFalloJugador : TipoEvento.animFalloEnemigo,
      ));

      ev.add(EventoBatalla(
        TipoEvento.texto,
        mensaje: "Fallo.",
      ));

      return ev;
    }

    // Movimientos puramente de estado (onda trueno, tóxico...)
    if (movimiento.categoria == CategoriaMovimiento.estado ||
        movimiento.poder <= 0) {
      _resolverMovimientoEstado(
        atacante: atacante,
        defensor: defensor,
        movimiento: movimiento,
        esJugador: esJugador,
        eventos: ev,
      );
      return ev;
    }

    // Cálculo de daño para movimientos ofensivos
    final danio = _calcularDanio(atacante, defensor, movimiento);

    // Animación de daño
    ev.add(EventoBatalla(
      esJugador ? TipoEvento.animDanoEnemigo : TipoEvento.animDanoJugador,
    ));

    // Aplicación de daño
    ev.add(EventoBatalla(
      esJugador ? TipoEvento.aplicarDanioEnemigo : TipoEvento.aplicarDanioJugador,
      mensaje: "$danio",
    ));

    // Mensaje de daño
    ev.add(EventoBatalla(
      TipoEvento.texto,
      mensaje: "${defensor.nombre} perdió $danio HP.",
    ));

    // Efectividad (muy eficaz, no eficaz, etc.)
    final eff = efectividad(movimiento.tipo, defensor.tipoPrimario);
    final desc = descripcionEfectividad(eff);

    ev.add(EventoBatalla(TipoEvento.texto, mensaje: desc['texto']));

    // Posibles efectos secundarios (rayo 10%, fuego 10% etc.)
    ev.addAll(_eventosEstadoSecundario(
      movimiento: movimiento,
      atacante: atacante,
      defensor: defensor,
      esJugador: esJugador,
    ));

    return ev;
  }


  // =========================================================
  //      MOVIMIENTOS DE ESTADO PUROS
  // =========================================================

  void _resolverMovimientoEstado({
    required Pokemon atacante,
    required Pokemon defensor,
    required Movimiento movimiento,
    required bool esJugador,
    required List<EventoBatalla> eventos,
  }) {

    // Estos casos checan nombre.

    switch (movimiento.nombre) {

      case 'Onda Trueno':
        if (defensor.estado != EstadoAlterado.ninguno) {
          eventos.add(EventoBatalla(
            TipoEvento.texto,
            mensaje: "Pero no pasó nada.",
          ));
          return;
        }

        eventos.add(EventoBatalla(
          esJugador ? TipoEvento.animParalizadoEnemigo
                    : TipoEvento.animParalizadoJugador,
        ));

        eventos.add(EventoBatalla(
          TipoEvento.texto,
          mensaje: "${defensor.nombre} está paralizado.",
        ));

        eventos.add(EventoBatalla(
          esJugador ? TipoEvento.aplicarEstadoEnemigo
                    : TipoEvento.aplicarEstadoJugador,
          mensaje: "paralizado",
        ));
        return;


      case 'Tóxico':
      case 'Polvo Veneno':
        if (defensor.estado == EstadoAlterado.ninguno) {

          eventos.add(EventoBatalla(
            esJugador ? TipoEvento.animEstadoEnemigo
                      : TipoEvento.animEstadoJugador,
          ));

          eventos.add(EventoBatalla(
            TipoEvento.texto,
            mensaje: "${defensor.nombre} fue envenenado.",
          ));

          eventos.add(EventoBatalla(
            esJugador ? TipoEvento.aplicarEstadoEnemigo
                      : TipoEvento.aplicarEstadoJugador,
            mensaje: "envenenado",
          ));
        } else {
          eventos.add(EventoBatalla(
            TipoEvento.texto,
            mensaje: "Pero no pasó nada.",
          ));
        }
        return;


      case 'Quemadura':
        if (defensor.estado == EstadoAlterado.ninguno) {

          eventos.add(EventoBatalla(
            esJugador ? TipoEvento.animEstadoEnemigo
                      : TipoEvento.animEstadoJugador,
          ));

          eventos.add(EventoBatalla(
            TipoEvento.texto,
            mensaje: "${defensor.nombre} sufrió quemadura.",
          ));

          eventos.add(EventoBatalla(
            esJugador ? TipoEvento.aplicarEstadoEnemigo
                      : TipoEvento.aplicarEstadoJugador,
            mensaje: "quemado",
          ));
        }
        return;


      case 'Congelar':
        if (defensor.estado == EstadoAlterado.ninguno) {

          eventos.add(EventoBatalla(
            esJugador ? TipoEvento.animEstadoEnemigo
                      : TipoEvento.animEstadoJugador,
          ));

          eventos.add(EventoBatalla(
            TipoEvento.texto,
            mensaje: "${defensor.nombre} fue congelado.",
          ));

          eventos.add(EventoBatalla(
            esJugador ? TipoEvento.aplicarEstadoEnemigo
                      : TipoEvento.aplicarEstadoJugador,
            mensaje: "congelado",
          ));
        }
        return;


      case 'Onda Eléctrica':
        if (defensor.estado == EstadoAlterado.ninguno) {

          eventos.add(EventoBatalla(
            esJugador ? TipoEvento.animEstadoEnemigo
                      : TipoEvento.animEstadoJugador,
          ));

          eventos.add(EventoBatalla(
            TipoEvento.texto,
            mensaje: "${defensor.nombre} está paralizado.",
          ));

          eventos.add(EventoBatalla(
            esJugador ? TipoEvento.aplicarEstadoEnemigo
                      : TipoEvento.aplicarEstadoJugador,
            mensaje: "paralizado",
          ));
        }
        return;

      default:
        eventos.add(EventoBatalla(
          TipoEvento.texto,
          mensaje: "Pero no pasó nada.",
        ));
    }
  }


  // =========================================================
  //     EFECTOS SECUNDARIOS (Rayo, fuego, etc.)
  // =========================================================

  List<EventoBatalla> _eventosEstadoSecundario({
    required Movimiento movimiento,
    required Pokemon atacante,
    required Pokemon defensor,
    required bool esJugador,
  }) {
    final ev = <EventoBatalla>[];

    void aplicar(EstadoAlterado est) {
      if (defensor.estado != EstadoAlterado.ninguno) return;

      // Aplicación
      ev.add(EventoBatalla(
        esJugador ? TipoEvento.aplicarEstadoEnemigo
                  : TipoEvento.aplicarEstadoJugador,
        mensaje: _nombreEstado(est),
      ));

      ev.add(EventoBatalla(
        esJugador ? TipoEvento.animEstadoEnemigo
                  : TipoEvento.animEstadoJugador,
      ));

      ev.add(EventoBatalla(
        TipoEvento.texto,
        mensaje: "${defensor.nombre} ahora está ${_nombreEstado(est)}.",
      ));
    }

    // Rayo = 10% parálisis
    if (movimiento.nombre == "Rayo") {
      if (_rng.nextInt(100) < 10) aplicar(EstadoAlterado.paralizado);
    }

    // Fuego = 10% quemadura
    if (movimiento.tipo == "Fuego") {
      if (_rng.nextInt(100) < 10) aplicar(EstadoAlterado.quemado);
    }

    return ev;
  }


  // =========================================================
  //  TRADUCCIÓN DE ESTADO A TEXTO
  // =========================================================

  String _nombreEstado(EstadoAlterado e) {
    switch (e) {
      case EstadoAlterado.paralizado:
        return "paralizado";
      case EstadoAlterado.quemado:
        return "quemado";
      case EstadoAlterado.envenenado:
        return "envenenado";
      case EstadoAlterado.congelado:
        return "congelado";
      default:
        return "alterado";
    }
  }


  // =========================================================
  //      EFECTOS DE ESTADO AL FINAL DEL TURNO
  // =========================================================

  List<EventoBatalla> _eventosFinDeTurno(Pokemon p, bool esJugador) {
    final ev = <EventoBatalla>[];

    // Congelado no genera efectos de fin de turno
    if (p.estado == EstadoAlterado.congelado) {
      return ev;
    }

    // Veneno
    if (p.estado == EstadoAlterado.envenenado) {
      final danio = (p.hpMaximo / 8).round();

      ev.add(EventoBatalla(
        esJugador ? TipoEvento.aplicarDanioJugador
                  : TipoEvento.aplicarDanioEnemigo,
        mensaje: "$danio",
      ));

      ev.add(EventoBatalla(
        TipoEvento.texto,
        mensaje: "${p.nombre} sufre daño por veneno.",
      ));
    }

    // Quemadura
    if (p.estado == EstadoAlterado.quemado) {
      final danio = (p.hpMaximo / 8).round();

      ev.add(EventoBatalla(
        esJugador ? TipoEvento.aplicarDanioJugador
                  : TipoEvento.aplicarDanioEnemigo,
        mensaje: "$danio",
      ));

      ev.add(EventoBatalla(
        TipoEvento.texto,
        mensaje: "${p.nombre} sufre daño por quemadura.",
      ));
    }

    return ev;
  }

  // =========================================================
  //   BLOQUEO DE ATAQUE SEGÚN ESTADO ALTERADO
  // =========================================================

  EventoBatalla? _bloqueoEstado(Pokemon p, bool esJugador) {
    switch (p.estado) {

      case EstadoAlterado.congelado:
        // 20% de descongelarse
        if (_rng.nextInt(100) < 20) {
          return EventoBatalla(
            esJugador ? TipoEvento.aplicarDescongeladoJugador
                      : TipoEvento.aplicarDescongeladoEnemigo,
            mensaje: "${p.nombre} se descongeló!",
          );
        }

        // 80% sigue congelado
        return EventoBatalla(
          esJugador ? TipoEvento.animParalizadoJugador
                    : TipoEvento.animParalizadoEnemigo,
          mensaje: "${p.nombre} está congelado y no puede moverse.",
        );

      case EstadoAlterado.paralizado:
        if (_rng.nextInt(100) < 20) {
          return EventoBatalla(
            esJugador ? TipoEvento.animParalizadoJugador
                      : TipoEvento.animParalizadoEnemigo,
            mensaje: "${p.nombre} está paralizado y no puede moverse.",
          );
        }
        return null;

      default:
        return null;
    }
  }

  // =========================================================
  //                    CÁLCULO DEL DAÑO
  // =========================================================

  int _calcularDanio(Pokemon atacante, Pokemon defensor, Movimiento mov) {
    final esFisico = mov.categoria == CategoriaMovimiento.fisico;

    int atk = esFisico ? atacante.ataque : atacante.ataqueEspecial;
    int def = esFisico ? defensor.defensa : defensor.defensaEspecial;

    // Quemadura reduce ataque físico
    if (esFisico && atacante.estaQuemado) atk ~/= 2;

    final nivel = atacante.nivel;

    // Fórmula estándar:
    // base = ((2*nivel)/5) + 2
    final base = ((2 * nivel) ~/ 5) + 2;

    // mut = ((((base * poder * atk) / def) / 50) + 2)
    final mut = ((base * mov.poder * atk) ~/ (50 * def)) + 2;

    // Si el ataque es del mismo tipo que el pokemon, se puede presentar un bonus como en los juegos oficiales
    final stab = mov.tipo == atacante.tipoPrimario ? 1.5 : 1.0;

    // Efectividad
    final eff = efectividad(mov.tipo, defensor.tipoPrimario);

    // Variación aleatoria 0.85 - 1.00
    final rnd = 0.85 + _rng.nextDouble() * 0.15;

    final mod = stab * eff * rnd;

    return (mut * mod).round();
  }


  // =========================================================
  //                ORDEN DE ATAQUE
  // =========================================================

  bool _decidirOrden(
      Movimiento movJ, Pokemon pokeJ, Movimiento movE, Pokemon pokeE) {

    // Prioridad del movimiento manda primero
    if (movJ.prioridad != movE.prioridad) {
      return movJ.prioridad > movE.prioridad;
    }

    // Velocidad
    int vJ = pokeJ.velocidad;
    int vE = pokeE.velocidad;

    // Parálisis reduce velocidad a la mitad
    if (pokeJ.estaParalizado) vJ ~/= 2;
    if (pokeE.estaParalizado) vE ~/= 2;

    if (vJ != vE) return vJ > vE;

    // Empate total: al azar
    return _rng.nextBool();
  }


  // =========================================================
  //                          ÍTEMS
  // =========================================================

  ResultadoTurno usarItemSobreJugador(Item item, int idxItem) {
    final ev = <EventoBatalla>[];

    // Texto inicial
    ev.add(EventoBatalla(
      TipoEvento.usarItemJugador,
      mensaje: "Usaste ${item.nombre}.",
    ));

    bool consumido = false;

    // CURACIÓN DE HP
    if (item.tipo == TipoItem.curaHP) {
      final monto = item.montoHP ?? 0;

      if (activoA.estaDebilitado) {
        ev.add(EventoBatalla(
          TipoEvento.texto,
          mensaje: "No surte efecto en un Pokémon debilitado.",
        ));
      } else if (activoA.hpActual >= activoA.hpMaximo) {
        ev.add(EventoBatalla(
          TipoEvento.texto,
          mensaje: "Los PS ya están al máximo.",
        ));
      } else {
        ev.add(EventoBatalla(
          TipoEvento.aplicarCuracionJugador,
          mensaje: "$monto",
        ));

        ev.add(EventoBatalla(
          TipoEvento.texto,
          mensaje: "Los PS fueron restaurados.",
        ));

        consumido = true;
      }
    }

    // CURA ESTADO
    else if (item.tipo == TipoItem.curaEstado) {
      if (activoA.estado == EstadoAlterado.ninguno) {
        ev.add(EventoBatalla(
          TipoEvento.texto,
          mensaje: "Pero no pasó nada.",
        ));
      } else {
        final objetivo = item.cura;
        final estadoActual = activoA.estado;

        final esCuraTotal =
            (objetivo == null || objetivo == EstadoAlterado.ninguno);
        final coincide = objetivo == estadoActual;

        if (esCuraTotal || coincide) {
          ev.add(EventoBatalla(
            TipoEvento.aplicarEstadoCuradoJugador,
            mensaje: "",
          ));

          ev.add(EventoBatalla(
            TipoEvento.texto,
            mensaje: "Se curó el estado alterado.",
          ));

          consumido = true;
        } else {
          ev.add(EventoBatalla(
            TipoEvento.texto,
            mensaje: "No tuvo efecto.",
          ));
        }
      }
    }

    // Se consume el ítem si correspondió
    if (consumido) {
      item.cantidad--;
      if (item.cantidad <= 0 &&
          idxItem >= 0 &&
          idxItem < mochila.length &&
          mochila[idxItem] == item) {
        mochila.removeAt(idxItem);
      }
    }

    // Luego el enemigo ataca si la batalla sigue
    if (!enemigoDerrotado && !jugadorDerrotado) {
      final movE =
          activoB.movimientos[_rng.nextInt(activoB.movimientos.length)];

      ev.addAll(_eventosAtaque(
        atacante: activoB,
        defensor: activoA,
        movimiento: movE,
        esJugador: false,
      ));
    }

    return ResultadoTurno(eventos: ev);
  }

  // =========================================================
  //                 CAMBIO MANUAL DE POKÉMON
  // =========================================================

  String jugadorCambia(int idx) {
    if (idx < 0 || idx >= equipoA.length) return "Índice inválido.";

    final p = equipoA[idx];

    if (p.estaDebilitado) return "${p.nombre} está debilitado.";
    if (identical(p, activoA)) return "${p.nombre} ya está en batalla.";

    activoA = p;
    return "Vas ${p.nombre}.";
  }

  // =========================================================
  //      CAMBIO AUTOMÁTICO CUANDO UN POKÉMON CAE
  // =========================================================

  Pokemon? cambioAuto(bool esJugador) {
    final lista = esJugador ? equipoA : equipoB;
    final vivos = lista.where((p) => !p.estaDebilitado).toList();

    if (vivos.isEmpty) return null;

    final nuevo = vivos.first;

    if (esJugador) {
      activoA = nuevo;
    } else {
      activoB = nuevo;
    }

    return nuevo;
  }
}
