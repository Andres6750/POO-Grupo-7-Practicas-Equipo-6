// lib/controllers/manager.dart

//guarda datos persistentes (nombre del jugador)
import 'package:shared_preferences/shared_preferences.dart';

import '../models/pokemon.dart';

//Saca de aqui el roster de pokemon disponibles
import '../data/roster.dart';

import '../models/item.dart';

//Singleton para en cualquier lado apuntar al game manager.
class GameManager {
  static final GameManager _instance = GameManager._internal();
  factory GameManager() => _instance;
  GameManager._internal();

  //Nombre del jugador
  String jugadorNombre = "";

  //Sprite default
  String spriteEntrenador = "hombre"; // valor default

    //Dificultad seleccionada
  String dificultad = "facil";

  //Items que lleva el jugador en la mochila
  List<Item> itemsJugador = [];

  //Lista de 30 pokemon disponibles de elegir al azar
  List<Pokemon> roster30 = [];

  //Equipo del jugador
  List<Pokemon> equipoJugador = [];

  //Lista de enemigos a enfrentar (5, elegidos al azar)
  List<String> torre = [];

  //Estos valores viven en memoria durante la sesión y se regeneran cuando inicias nueva partida.

  //Nueva partida
  //Hilo 

  Future<void> nuevaPartida(String nombre, String sprite, String dificultad) async {
    jugadorNombre = nombre;
    spriteEntrenador = sprite;

        // Guardar dificultad
    this.dificultad = dificultad;

    // La dificultad funciona de forma muy simple, se trata de con cuantos objetos comienzas.
    //Facil: 2 de todos los objetos disponibles
    //Medio: 1 de todos los objetos disponibles
    //Dificil: 3 objetos al azar
    if (dificultad == "facil") {
      itemsJugador = generarItemsFacil();
    } else if (dificultad == "medio") {
      itemsJugador = generarItemsMedio();
    } else {
      itemsJugador = generarItemsDificil();
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("jugadorNombre", nombre);
    await prefs.setString("spriteEntrenador", sprite);

    //Generamos el ROSTER 30 Pokémon
    roster30 = generarRoster20();
    equipoJugador = generarEquipo6(roster30);
    torre = generarTorre();
  }

List<Pokemon> generarRoster20() {
  final base = List<Pokemon>.from(rosterDefault());
  base.shuffle();

  // Tomamos 20 sin repetir
  final seleccionados = base.take(20).map((p) => _clonarPokemon(p)).toList();

  return seleccionados;
}

  //Sirve para crear el equipo inicial del jugador, formado por 6 Pokémon aleatorios, SIN repetir, SIN compartir IVs, SIN compartir HP, SIN compartir estados alterados.
  //Es la forma en que el jugador empieza la aventura con un equipo completamente suyo, distinto cada nueva partida.

  List<Pokemon> generarEquipo6(List<Pokemon> roster) {
    final copia = List<Pokemon>.from(roster)..shuffle();
    return copia.take(6).map((p) => _clonarPokemon(p)).toList();
  }

  //Generamos la torre
  List<String> generarTorre() {
    final amigos = ["Abdiel", "Alan", "Oswaldo", "Roberto", "Andres"];
    amigos.shuffle();
    const campeon = "Campeón de Liga";
    return [...amigos, campeon];
  }

  //Clonador para evitar pokemon repetidos de stats

  Pokemon _clonarPokemon(Pokemon p) {
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

  // ================================================================
  //                          ITEMS INICIALES
  // ================================================================

  List<Item> generarItemsFacil() {
    return [
      Item(nombre: "Poción", tipo: TipoItem.curaHP, cantidad: 2, montoHP: 20),
      Item(nombre: "Superpoción", tipo: TipoItem.curaHP, cantidad: 2, montoHP: 50),
      Item(nombre: "Hiperpoción", tipo: TipoItem.curaHP, cantidad: 2, montoHP: 200),

      Item(nombre: "Antídoto", tipo: TipoItem.curaEstado, cantidad: 2, cura: EstadoAlterado.envenenado),
      Item(nombre: "Antiparalizante", tipo: TipoItem.curaEstado, cantidad: 2, cura: EstadoAlterado.paralizado),
      Item(nombre: "Antiquemadura", tipo: TipoItem.curaEstado, cantidad: 2, cura: EstadoAlterado.quemado),
      Item(nombre: "Descongelante", tipo: TipoItem.curaEstado, cantidad: 2, cura: EstadoAlterado.congelado),

      Item(nombre: "Cura Total", tipo: TipoItem.curaEstado, cantidad: 2, cura: EstadoAlterado.ninguno),
    ];
  }

  List<Item> generarItemsMedio() {
    return [
      Item(nombre: "Poción", tipo: TipoItem.curaHP, cantidad: 1, montoHP: 20),
      Item(nombre: "Superpoción", tipo: TipoItem.curaHP, cantidad: 1, montoHP: 50),
      Item(nombre: "Hiperpoción", tipo: TipoItem.curaHP, cantidad: 1, montoHP: 200),

      Item(nombre: "Antídoto", tipo: TipoItem.curaEstado, cantidad: 1, cura: EstadoAlterado.envenenado),
      Item(nombre: "Antiparalizante", tipo: TipoItem.curaEstado, cantidad: 1, cura: EstadoAlterado.paralizado),
      Item(nombre: "Antiquemadura", tipo: TipoItem.curaEstado, cantidad: 1, cura: EstadoAlterado.quemado),
      Item(nombre: "Descongelante", tipo: TipoItem.curaEstado, cantidad: 1, cura: EstadoAlterado.congelado),

      Item(nombre: "Cura Total", tipo: TipoItem.curaEstado, cantidad: 1, cura: EstadoAlterado.ninguno),
    ];
  }

  List<Item> generarItemsDificil() {
    final lista = [
      Item(nombre: "Poción", tipo: TipoItem.curaHP, cantidad: 1, montoHP: 20),
      Item(nombre: "Superpoción", tipo: TipoItem.curaHP, cantidad: 1, montoHP: 50),
      Item(nombre: "Hiperpoción", tipo: TipoItem.curaHP, cantidad: 1, montoHP: 200),

      Item(nombre: "Antídoto", tipo: TipoItem.curaEstado, cantidad: 1, cura: EstadoAlterado.envenenado),
      Item(nombre: "Antiparalizante", tipo: TipoItem.curaEstado, cantidad: 1, cura: EstadoAlterado.paralizado),
      Item(nombre: "Antiquemadura", tipo: TipoItem.curaEstado, cantidad: 1, cura: EstadoAlterado.quemado),
      Item(nombre: "Descongelante", tipo: TipoItem.curaEstado, cantidad: 1, cura: EstadoAlterado.congelado),

      Item(nombre: "Cura Total", tipo: TipoItem.curaEstado, cantidad: 1, cura: EstadoAlterado.ninguno),
    ];

    lista.shuffle();
    return lista.take(3).toList();
  }

}
