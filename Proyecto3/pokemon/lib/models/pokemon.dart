// lib/models/pokemon.dart

//Importa movimientos
import 'movimiento.dart';

//importa la funcion random
import 'dart:math';

//Clase pokemon
class Pokemon {
  //Nombre
  final String nombre;
  //Tipo primario
  final String tipoPrimario;

  // Stats base
  final int baseHP;
  final int baseAtk;
  final int baseDef;
  final int baseSpAtk;
  final int baseSpDef;
  final int baseSpeed;

  // Nivel en batalla (por defecto 50)
  final int nivel;

  // Movimientos conocidos en una lista de objetos movimiento
  final List<Movimiento> movimientos;

  // IVs (generados una vez) 
  late final int ivHP;
  late final int ivAtk;
  late final int ivDef;
  late final int ivSpAtk;
  late final int ivSpDef;
  late final int ivSpeed;

  // Stats finales en batalla (calculados una vez en el constructor)
  late final int hpMaximo;
  late final int ataque;
  late final int defensa;
  late final int ataqueEspecial;
  late final int defensaEspecial;
  late final int velocidad;

  // HP actual (mutable)
  late int hpActual;

  //Random interno
  final _rand = Random();

  //Estados alterados

  //Estado actual del pokemon
  EstadoAlterado estado = EstadoAlterado.ninguno;

  //Getters de estado

  // Turnos congelado (se descongela aleatoriamente)
  int turnosCongelado = 0;

  // Para quemado: reduce ataque físico
  bool get estaQuemado => estado == EstadoAlterado.quemado;

  // Para paralizado: velocidad a la mitad
  bool get estaParalizado => estado == EstadoAlterado.paralizado;

  // Para congelado: no puede atacar
  bool get estaCongelado => estado == EstadoAlterado.congelado;

  // Para envenenado: daño cada turno
  bool get estaEnvenenado => estado == EstadoAlterado.envenenado;
  
  //Constructor
  Pokemon({
    required this.nombre,
    required this.tipoPrimario,
    required this.baseHP,
    required this.baseAtk,
    required this.baseDef,
    required this.baseSpAtk,
    required this.baseSpDef,
    required this.baseSpeed,
    this.nivel = 50,
    required this.movimientos,
  }) {
    // Generar IVs (una vez)
    ivHP = _rand.nextInt(32);
    ivAtk = _rand.nextInt(32);
    ivDef = _rand.nextInt(32);
    ivSpAtk = _rand.nextInt(32);
    ivSpDef = _rand.nextInt(32);
    ivSpeed = _rand.nextInt(32);

    // Calcular stats finales
    hpMaximo = _calcularHP(baseHP, ivHP);
    ataque = _calcularStat(baseAtk, ivAtk);
    defensa = _calcularStat(baseDef, ivDef);
    ataqueEspecial = _calcularStat(baseSpAtk, ivSpAtk);
    defensaEspecial = _calcularStat(baseSpDef, ivSpDef);
    velocidad = _calcularStat(baseSpeed, ivSpeed);

    // HP actual inicia lleno
    hpActual = hpMaximo;
  }

  //Fórmulas

  int _calcularHP(int base, int iv) {
    final ev = 0;
    return (((2 * base + iv + (ev ~/ 4)) * nivel) ~/ 100) + nivel + 10;
  }

  int _calcularStat(int base, int iv) {
    final ev = 0;
    return (((2 * base + iv + (ev ~/ 4)) * nivel) ~/ 100) + 5;
  }

  // Mas getters pero la UI
  double get proporcionHP => hpActual / hpMaximo;
  bool get estaDebilitado => hpActual <= 0;

  // Aplicar daño (no negativo)
  void recibirDanio(int danio) {
    hpActual -= danio;
    if (hpActual < 0) hpActual = 0;
  }

  void curar(int cantidad) {
  hpActual = min(hpActual + cantidad, hpMaximo);
  }

  // Curar al máximo
  void curarAlMaximo() => hpActual = hpMaximo;

  //Descripcion corta del pokemon (debug)
  @override
  String toString() =>
      '$nombre Nv.$nivel HP: $hpActual/$hpMaximo Tipo: $tipoPrimario';
}

//Enum para los estados
enum EstadoAlterado {
  ninguno,
  envenenado,
  quemado,
  congelado,
  paralizado,
}
