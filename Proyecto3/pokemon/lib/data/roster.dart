// lib/data/roster.dart
//
// *** BASE DE DATOS INICIAL DEL JUEGO ***
// Aquí definimos movimientos y Pokémon disponibles para construir equipos.
//

import '../models/movimiento.dart';
import '../models/pokemon.dart';


// ================================================================
//                        MOVIMIENTOS
// ================================================================
// Estructura para nuevos movimientos:
//
// const Movimiento nombre = Movimiento(
//   nombre: 'Nombre del movimiento',
//   tipo: 'Tipo',                       // Debe existir en tablaDeTipos
//   categoria: CategoriaMovimiento.fisico / especial / estado,
//   poder: 0 o número,                  // 0 si es movimiento de estado
//   precision: 100,                     // 1–100
//   prioridad: 0,                        // valores típicos: -7 a +5
// );
//
// EJEMPLOS REALES DE PRIORIDAD:
//   Ataque Rápido = +1
//   Velocidad Extrema = +2
//   Protección = +4
//   Contraataque = -5
//
// ================================================================

// Eléctrico
final Movimiento rayo = Movimiento(
  nombre: 'Rayo',
  tipo: 'Eléctrico',
  categoria: CategoriaMovimiento.especial,
  poder: 90,
  precision: 100,
  prioridad: 0,
);

final Movimiento ataqueRapido = Movimiento(
  nombre: 'Ataque Rápido',
  tipo: 'Normal',
  categoria: CategoriaMovimiento.fisico,
  poder: 40,
  precision: 100,
  prioridad: 1,       // movimiento prioritario
);

final Movimiento ondaTrueno = Movimiento(
  nombre: 'Onda Trueno',
  tipo: 'Eléctrico',
  categoria: CategoriaMovimiento.estado,
  poder: 0,          // movimiento de estado
  precision: 90,
  prioridad: 0,
);

final Movimiento ondaElectrica = Movimiento(
  nombre: 'Onda Eléctrica',
  tipo: 'Eléctrico',
  categoria: CategoriaMovimiento.estado,
  poder: 0,
  precision: 95,
  prioridad: 0,
);


// Fuego
final Movimiento lanzallamas = Movimiento(
  nombre: 'Lanzallamas',
  tipo: 'Fuego',
  categoria: CategoriaMovimiento.especial,
  poder: 90,
  precision: 100,
  prioridad: 0,
);

final Movimiento ascuas = Movimiento(
  nombre: 'Ascuas',
  tipo: 'Fuego',
  categoria: CategoriaMovimiento.especial,
  poder: 40,
  precision: 100,
  prioridad: 0,
);

// Planta
final Movimiento latigoCepa = Movimiento(
  nombre: 'Látigo Cepa',
  tipo: 'Planta',
  categoria: CategoriaMovimiento.fisico,
  poder: 45,
  precision: 100,
  prioridad: 0,
);

final Movimiento hojaAfilada = Movimiento(
  nombre: 'Hoja Afilada',
  tipo: 'Planta',
  categoria: CategoriaMovimiento.fisico,
  poder: 55,
  precision: 95,
  prioridad: 0,
);

// Agua
final Movimiento pistolaAgua = Movimiento(
  nombre: 'Pistola Agua',
  tipo: 'Agua',
  categoria: CategoriaMovimiento.especial,
  poder: 40,
  precision: 100,
  prioridad: 0,
);

final Movimiento surf = Movimiento(
  nombre: 'Surf',
  tipo: 'Agua',
  categoria: CategoriaMovimiento.especial,
  poder: 90,
  precision: 100,
  prioridad: 0,
);

// Fantasma / Psíquico
final Movimiento bolaSombra = Movimiento(
  nombre: 'Bola Sombra',
  tipo: 'Fantasma',
  categoria: CategoriaMovimiento.especial,
  poder: 80,
  precision: 100,
  prioridad: 0,
);

final Movimiento psiquico = Movimiento(
  nombre: 'Psíquico',
  tipo: 'Psíquico',
  categoria: CategoriaMovimiento.especial,
  poder: 90,
  precision: 100,
  prioridad: 0,
);

// Normal
final Movimiento placaje = Movimiento(
  nombre: 'Placaje',
  tipo: 'Normal',
  categoria: CategoriaMovimiento.fisico,
  poder: 40,
  precision: 100,
  prioridad: 0,
);

final Movimiento toxico = Movimiento(
  nombre: 'Tóxico',
  tipo: 'Veneno',
  categoria: CategoriaMovimiento.estado,
  poder: 0,
  precision: 90,
  prioridad: 0,
);

final Movimiento polvoVeneno = Movimiento(
  nombre: 'Polvo Veneno',
  tipo: 'Veneno',
  categoria: CategoriaMovimiento.estado,
  poder: 0,
  precision: 75,
  prioridad: 0,
);

final Movimiento ascuasEstado = Movimiento(
  nombre: 'Quemadura',
  tipo: 'Fuego',
  categoria: CategoriaMovimiento.estado,
  poder: 0,
  precision: 85,
  prioridad: 0,
);

final Movimiento congelar = Movimiento(
  nombre: 'Congelar',
  tipo: 'Hielo',
  categoria: CategoriaMovimiento.estado,
  poder: 0,
  precision: 90,
  prioridad: 0,
);



final Movimiento colaDragon = Movimiento(
  nombre: 'Cola Dragón',
  tipo: 'Dragón',
  categoria: CategoriaMovimiento.fisico,
  poder: 60,
  precision: 90,
  prioridad: 0,
);

final Movimiento garraDragon = Movimiento(
  nombre: 'Garra Dragón',
  tipo: 'Dragón',
  categoria: CategoriaMovimiento.fisico,
  poder: 80,
  precision: 100,
  prioridad: 0,
);

final Movimiento terremoto = Movimiento(
  nombre: 'Terremoto',
  tipo: 'Tierra',
  categoria: CategoriaMovimiento.fisico,
  poder: 100,
  precision: 100,
  prioridad: 0,
);

final Movimiento hojaAguda = Movimiento(
  nombre: 'Hoja Aguda',
  tipo: 'Planta',
  categoria: CategoriaMovimiento.fisico,
  poder: 70,
  precision: 100,
  prioridad: 0,
);

final Movimiento garraMetal = Movimiento(
  nombre: 'Garra Metal',
  tipo: 'Acero',
  categoria: CategoriaMovimiento.fisico,
  poder: 50,
  precision: 95,
  prioridad: 0,
);

final Movimiento punioFuego = Movimiento(
  nombre: 'Puño Fuego',
  tipo: 'Fuego',
  categoria: CategoriaMovimiento.fisico,
  poder: 75,
  precision: 100,
  prioridad: 0,
);

final Movimiento punioHielo = Movimiento(
  nombre: 'Puño Hielo',
  tipo: 'Hielo',
  categoria: CategoriaMovimiento.fisico,
  poder: 75,
  precision: 100,
  prioridad: 0,
);

final Movimiento punioTrueno = Movimiento(
  nombre: 'Puño Trueno',
  tipo: 'Eléctrico',
  categoria: CategoriaMovimiento.fisico,
  poder: 75,
  precision: 100,
  prioridad: 0,
);

final Movimiento poderOculto = Movimiento(
  nombre: 'Poder Oculto',
  tipo: 'Normal',
  categoria: CategoriaMovimiento.especial,
  poder: 60,
  precision: 100,
  prioridad: 0,
);

final Movimiento pulsoUmbrio = Movimiento(
  nombre: 'Pulso Umbrío',
  tipo: 'Siniestro',
  categoria: CategoriaMovimiento.especial,
  poder: 80,
  precision: 100,
  prioridad: 0,
);

final Movimiento vientoCortante = Movimiento(
  nombre: 'Viento Cortante',
  tipo: 'Volador',
  categoria: CategoriaMovimiento.especial,
  poder: 60,
  precision: 100,
  prioridad: 0,
);

final Movimiento ataqueAereo = Movimiento(
  nombre: 'Ataque Aéreo',
  tipo: 'Volador',
  categoria: CategoriaMovimiento.fisico,
  poder: 90,
  precision: 95,
  prioridad: 0,
);

final Movimiento zumbido = Movimiento(
  nombre: 'Zumbido',
  tipo: 'Bicho',
  categoria: CategoriaMovimiento.especial,
  poder: 90,
  precision: 100,
  prioridad: 0,
);

final Movimiento golpeCruzado = Movimiento(
  nombre: 'Golpe Cruzado',
  tipo: 'Lucha',
  categoria: CategoriaMovimiento.fisico,
  poder: 100,
  precision: 80,
  prioridad: 0,
);

final Movimiento avalancha = Movimiento(
  nombre: 'Avalancha',
  tipo: 'Roca',
  categoria: CategoriaMovimiento.fisico,
  poder: 75,
  precision: 90,
  prioridad: 0,
);

final Movimiento brilloMagico = Movimiento(
  nombre: 'Brillo Mágico',
  tipo: 'Hada',
  categoria: CategoriaMovimiento.especial,
  poder: 80,
  precision: 100,
  prioridad: 0,
);

final Movimiento hiperColmillo = Movimiento(
  nombre: 'Híper Colmillo',
  tipo: 'Normal',
  categoria: CategoriaMovimiento.fisico,
  poder: 80,
  precision: 90,
  prioridad: 0,
);

final Movimiento bombaLodo = Movimiento(
  nombre: 'Bomba Lodo',
  tipo: 'Veneno',
  categoria: CategoriaMovimiento.especial,
  poder: 90,
  precision: 100,
  prioridad: 0,
);

final Movimiento confusion = Movimiento(
  nombre: 'Confusión',
  tipo: 'Psíquico',
  categoria: CategoriaMovimiento.especial,
  poder: 50,
  precision: 100,
  prioridad: 1,
);

final Movimiento enfado = Movimiento(
  nombre: 'Enfado',
  tipo: 'Dragón',
  categoria: CategoriaMovimiento.fisico,
  poder: 120,
  precision: 100,
  prioridad: 0,
);

// ================================================================
//                        CREADORES DE POKÉMON
// ================================================================
// Estructura recomendada:
//
// Pokemon crearNombre() => Pokemon(
//   nombre: 'Nombre',
//   tipoPrimario: 'Tipo',
//   baseHP: 80,
//   baseAtk: 100,
//   baseDef: 70,
//   baseSpAtk: 100,
//   baseSpDef: 70,
//   baseSpeed: 90,
//   movimientos: [
//      movimiento1,
//      movimiento2,
//      movimiento3,
//      movimiento4,
//   ],
// );
//
// ================================================================

Pokemon crearPikachu() => Pokemon(
  nombre: 'Pikachu',
  tipoPrimario: 'Eléctrico',
  baseHP: 35,
  baseAtk: 55,
  baseDef: 40,
  baseSpAtk: 50,
  baseSpDef: 50,
  baseSpeed: 90,
  movimientos: [rayo, ondaTrueno, ondaElectrica],
);


Pokemon crearCharmander() => Pokemon(
  nombre: 'Charmander',
  tipoPrimario: 'Fuego',
  baseHP: 39,
  baseAtk: 52,
  baseDef: 43,
  baseSpAtk: 60,
  baseSpDef: 50,
  baseSpeed: 65,
  movimientos: [lanzallamas, ascuasEstado, ataqueRapido],
);


Pokemon crearBulbasaur() => Pokemon(
  nombre: 'Bulbasaur',
  tipoPrimario: 'Planta',
  baseHP: 45,
  baseAtk: 49,
  baseDef: 49,
  baseSpAtk: 65,
  baseSpDef: 65,
  baseSpeed: 45,
  movimientos: [latigoCepa, hojaAfilada, polvoVeneno],
);

Pokemon crearSquirtle() => Pokemon(
  nombre: 'Squirtle',
  tipoPrimario: 'Agua',
  baseHP: 44,
  baseAtk: 48,
  baseDef: 65,
  baseSpAtk: 50,
  baseSpDef: 64,
  baseSpeed: 43,
  movimientos: [pistolaAgua, surf, congelar],
);

Pokemon crearGengar() => Pokemon(
  nombre: 'Gengar',
  tipoPrimario: 'Fantasma',
  baseHP: 60,
  baseAtk: 65,
  baseDef: 60,
  baseSpAtk: 130,
  baseSpDef: 75,
  baseSpeed: 110,
  movimientos: [bolaSombra, psiquico, rayo],
);

Pokemon crearAlakazam() => Pokemon(
  nombre: 'Alakazam',
  tipoPrimario: 'Psíquico',
  baseHP: 55,
  baseAtk: 50,
  baseDef: 45,
  baseSpAtk: 135,
  baseSpDef: 95,
  baseSpeed: 120,
  movimientos: [psiquico, bolaSombra, rayo],
);

Pokemon crearGarchomp() => Pokemon(
  nombre: 'Garchomp',
  tipoPrimario: 'Dragón',
  baseHP: 108,
  baseAtk: 130,
  baseDef: 95,
  baseSpAtk: 80,
  baseSpDef: 85,
  baseSpeed: 102,
  movimientos: [garraDragon, terremoto, ataqueRapido],
);

Pokemon crearTyranitar() => Pokemon(
  nombre: 'Tyranitar',
  tipoPrimario: 'Roca',
  baseHP: 100,
  baseAtk: 134,
  baseDef: 110,
  baseSpAtk: 95,
  baseSpDef: 100,
  baseSpeed: 61,
  movimientos: [garraMetal, terremoto, punioHielo],
);

Pokemon crearMetagross() => Pokemon(
  nombre: 'Metagross',
  tipoPrimario: 'Acero',
  baseHP: 80,
  baseAtk: 135,
  baseDef: 130,
  baseSpAtk: 95,
  baseSpDef: 90,
  baseSpeed: 70,
  movimientos: [garraMetal, psiquico, terremoto],
);

Pokemon crearSalamence() => Pokemon(
  nombre: 'Salamence',
  tipoPrimario: 'Dragón',
  baseHP: 95,
  baseAtk: 135,
  baseDef: 80,
  baseSpAtk: 110,
  baseSpDef: 80,
  baseSpeed: 100,
  movimientos: [garraDragon, lanzallamas, ataqueRapido],
);

Pokemon crearDragonite() => Pokemon(
  nombre: 'Dragonite',
  tipoPrimario: 'Dragón',
  baseHP: 91,
  baseAtk: 134,
  baseDef: 95,
  baseSpAtk: 100,
  baseSpDef: 100,
  baseSpeed: 80,
  movimientos: [garraDragon, punioFuego, ondaTrueno],
);

Pokemon crearGoodra() => Pokemon(
  nombre: 'Goodra',
  tipoPrimario: 'Dragón',
  baseHP: 90,
  baseAtk: 100,
  baseDef: 70,
  baseSpAtk: 110,
  baseSpDef: 150,
  baseSpeed: 80,
  movimientos: [garraDragon, poderOculto, ataqueRapido],
);

Pokemon crearSceptile() => Pokemon(
  nombre: 'Sceptile',
  tipoPrimario: 'Planta',
  baseHP: 70,
  baseAtk: 85,
  baseDef: 65,
  baseSpAtk: 105,
  baseSpDef: 85,
  baseSpeed: 120,
  movimientos: [hojaAguda, latigoCepa, ataqueRapido],
);

Pokemon crearAggron() => Pokemon(
  nombre: 'Aggron',
  tipoPrimario: 'Acero',
  baseHP: 70,
  baseAtk: 110,
  baseDef: 180,
  baseSpAtk: 60,
  baseSpDef: 60,
  baseSpeed: 50,
  movimientos: [garraMetal, terremoto, ataqueRapido],
);

Pokemon crearAbsol() => Pokemon(
  nombre: 'Absol',
  tipoPrimario: 'Siniestro',
  baseHP: 65,
  baseAtk: 130,
  baseDef: 60,
  baseSpAtk: 75,
  baseSpDef: 60,
  baseSpeed: 75,
  movimientos: [bolaSombra, ataqueRapido, garraMetal],
);

Pokemon crearArcanine() => Pokemon(
  nombre: 'Arcanine',
  tipoPrimario: 'Fuego',
  baseHP: 90,
  baseAtk: 110,
  baseDef: 80,
  baseSpAtk: 100,
  baseSpDef: 80,
  baseSpeed: 95,
  movimientos: [lanzallamas, ataqueRapido, punioFuego],
);

Pokemon crearVaporeon() => Pokemon(
  nombre: 'Vaporeon',
  tipoPrimario: 'Agua',
  baseHP: 130,
  baseAtk: 65,
  baseDef: 60,
  baseSpAtk: 110,
  baseSpDef: 95,
  baseSpeed: 65,
  movimientos: [surf, pistolaAgua, congelar],
);

Pokemon crearDonphan() => Pokemon(
  nombre: 'Donphan',
  tipoPrimario: 'Tierra',
  baseHP: 90,
  baseAtk: 120,
  baseDef: 120,
  baseSpAtk: 60,
  baseSpDef: 60,
  baseSpeed: 50,
  movimientos: [terremoto, ataqueRapido, hojaAguda],
);

Pokemon crearBreloom() => Pokemon(
  nombre: 'Breloom',
  tipoPrimario: 'Planta',
  baseHP: 60,
  baseAtk: 130,
  baseDef: 80,
  baseSpAtk: 60,
  baseSpDef: 60,
  baseSpeed: 70,
  movimientos: [latigoCepa, hojaAfilada, ataqueRapido],
);

Pokemon crearMagnezone() => Pokemon(
  nombre: 'Magnezone',
  tipoPrimario: 'Eléctrico',
  baseHP: 70,
  baseAtk: 70,
  baseDef: 115,
  baseSpAtk: 130,
  baseSpDef: 90,
  baseSpeed: 60,
  movimientos: [rayo, ondaElectrica, poderOculto],
);

Pokemon crearUmbreon() => Pokemon(
  nombre: 'Umbreon',
  tipoPrimario: 'Siniestro',
  baseHP: 95,
  baseAtk: 65,
  baseDef: 110,
  baseSpAtk: 60,
  baseSpDef: 130,
  baseSpeed: 65,
  movimientos: [bolaSombra, ataqueRapido, psiquico],
);

Pokemon crearSwampert() => Pokemon(
  nombre: 'Swampert',
  tipoPrimario: 'Agua',
  baseHP: 100,
  baseAtk: 110,
  baseDef: 90,
  baseSpAtk: 85,
  baseSpDef: 90,
  baseSpeed: 60,
  movimientos: [terremoto, surf, ataqueRapido],
);

Pokemon crearTogekiss() => Pokemon(
  nombre: 'Togekiss',
  tipoPrimario: 'Hada',
  baseHP: 85,
  baseAtk: 50,
  baseDef: 95,
  baseSpAtk: 120,
  baseSpDef: 115,
  baseSpeed: 80,
  movimientos: [poderOculto, psiquico, ataqueRapido],
);

Pokemon crearFerrothorn() => Pokemon(
  nombre: 'Ferrothorn',
  tipoPrimario: 'Planta',
  baseHP: 74,
  baseAtk: 94,
  baseDef: 131,
  baseSpAtk: 54,
  baseSpDef: 116,
  baseSpeed: 20,
  movimientos: [hojaAfilada, garraMetal, latigoCepa],
);

Pokemon crearInfernape() => Pokemon(
  nombre: 'Infernape',
  tipoPrimario: 'Fuego',
  baseHP: 76,
  baseAtk: 104,
  baseDef: 71,
  baseSpAtk: 104,
  baseSpDef: 71,
  baseSpeed: 108,
  movimientos: [lanzallamas, ataqueRapido, punioFuego],
);

Pokemon crearGliscor() => Pokemon(
  nombre: 'Gliscor',
  tipoPrimario: 'Tierra',
  baseHP: 75,
  baseAtk: 95,
  baseDef: 125,
  baseSpAtk: 45,
  baseSpDef: 75,
  baseSpeed: 95,
  movimientos: [terremoto, garraMetal, ataqueRapido],
);

Pokemon crearLucario() => Pokemon(
  nombre: 'Lucario',
  tipoPrimario: 'Lucha',
  baseHP: 70,
  baseAtk: 110,
  baseDef: 70,
  baseSpAtk: 115,
  baseSpDef: 70,
  baseSpeed: 90,
  movimientos: [garraMetal, psiquico, ataqueRapido],
);

Pokemon crearGardevoir() => Pokemon(
  nombre: 'Gardevoir',
  tipoPrimario: 'Psíquico',
  baseHP: 68,
  baseAtk: 65,
  baseDef: 65,
  baseSpAtk: 125,
  baseSpDef: 115,
  baseSpeed: 80,
  movimientos: [psiquico, bolaSombra, poderOculto],
);

Pokemon crearSnorlax() => Pokemon(
  nombre: 'Snorlax',
  tipoPrimario: 'Normal',
  baseHP: 160,
  baseAtk: 110,
  baseDef: 65,
  baseSpAtk: 65,
  baseSpDef: 110,
  baseSpeed: 30,
  movimientos: [placaje, ataqueRapido, poderOculto],
);

Pokemon crearGreninja() => Pokemon(
  nombre: 'Greninja',
  tipoPrimario: 'Agua',
  baseHP: 72,
  baseAtk: 95,
  baseDef: 67,
  baseSpAtk: 103,
  baseSpDef: 71,
  baseSpeed: 122,
  movimientos: [surf, psiquico, ataqueRapido],
);

Pokemon crearVenusaur() => Pokemon(
  nombre: 'Venusaur',
  tipoPrimario: 'Planta',
  baseHP: 80,
  baseAtk: 82,
  baseDef: 83,
  baseSpAtk: 100,
  baseSpDef: 100,
  baseSpeed: 80,
  movimientos: [hojaAfilada, latigoCepa, polvoVeneno],
);

Pokemon crearBlastoise() => Pokemon(
  nombre: 'Blastoise',
  tipoPrimario: 'Agua',
  baseHP: 79,
  baseAtk: 83,
  baseDef: 100,
  baseSpAtk: 85,
  baseSpDef: 105,
  baseSpeed: 78,
  movimientos: [surf, congelar, ataqueRapido],
);

Pokemon crearEspeon() => Pokemon(
  nombre: 'Espeon',
  tipoPrimario: 'Psíquico',
  baseHP: 65,
  baseAtk: 65,
  baseDef: 60,
  baseSpAtk: 130,
  baseSpDef: 95,
  baseSpeed: 110,
  movimientos: [psiquico, bolaSombra, ataqueRapido],
);

Pokemon crearTyphlosion() => Pokemon(
  nombre: 'Typhlosion',
  tipoPrimario: 'Fuego',
  baseHP: 78,
  baseAtk: 84,
  baseDef: 78,
  baseSpAtk: 109,
  baseSpDef: 85,
  baseSpeed: 100,
  movimientos: [lanzallamas, ataqueRapido, ascuasEstado],
);

Pokemon crearFeraligatr() => Pokemon(
  nombre: 'Feraligatr',
  tipoPrimario: 'Agua',
  baseHP: 85,
  baseAtk: 105,
  baseDef: 100,
  baseSpAtk: 79,
  baseSpDef: 83,
  baseSpeed: 78,
  movimientos: [surf, ataqueRapido, garraDragon],
);

Pokemon crearMeganium() => Pokemon(
  nombre: 'Meganium',
  tipoPrimario: 'Planta',
  baseHP: 80,
  baseAtk: 82,
  baseDef: 100,
  baseSpAtk: 83,
  baseSpDef: 100,
  baseSpeed: 80,
  movimientos: [latigoCepa, hojaAfilada, toxico],
);

Pokemon crearAmpharos() => Pokemon(
  nombre: 'Ampharos',
  tipoPrimario: 'Eléctrico',
  baseHP: 90,
  baseAtk: 75,
  baseDef: 85,
  baseSpAtk: 115,
  baseSpDef: 90,
  baseSpeed: 55,
  movimientos: [rayo, ondaElectrica, ataqueRapido],
);

Pokemon crearHeracross() => Pokemon(
  nombre: 'Heracross',
  tipoPrimario: 'Lucha',
  baseHP: 80,
  baseAtk: 125,
  baseDef: 75,
  baseSpAtk: 40,
  baseSpDef: 95,
  baseSpeed: 85,
  movimientos: [garraMetal, ataqueRapido, latigoCepa],
);

Pokemon crearTorterra() => Pokemon(
  nombre: 'Torterra',
  tipoPrimario: 'Planta',
  baseHP: 95,
  baseAtk: 109,
  baseDef: 105,
  baseSpAtk: 75,
  baseSpDef: 85,
  baseSpeed: 56,
  movimientos: [latigoCepa, hojaAfilada, terremoto],
);

Pokemon crearEmpoleon() => Pokemon(
  nombre: 'Empoleon',
  tipoPrimario: 'Agua',
  baseHP: 84,
  baseAtk: 86,
  baseDef: 88,
  baseSpAtk: 111,
  baseSpDef: 101,
  baseSpeed: 60,
  movimientos: [surf, garraMetal, congelar],
);

Pokemon crearLuxray() => Pokemon(
  nombre: 'Luxray',
  tipoPrimario: 'Eléctrico',
  baseHP: 80,
  baseAtk: 120,
  baseDef: 79,
  baseSpAtk: 95,
  baseSpDef: 79,
  baseSpeed: 70,
  movimientos: [rayo, ataqueRapido, poderOculto],
);

Pokemon crearRoserade() => Pokemon(
  nombre: 'Roserade',
  tipoPrimario: 'Planta',
  baseHP: 60,
  baseAtk: 70,
  baseDef: 65,
  baseSpAtk: 125,
  baseSpDef: 105,
  baseSpeed: 90,
  movimientos: [hojaAfilada, latigoCepa, toxico],
);

Pokemon crearCharizard() => Pokemon(
  nombre: 'Charizard',
  tipoPrimario: 'Fuego',
  baseHP: 78,
  baseAtk: 84,
  baseDef: 78,
  baseSpAtk: 109,
  baseSpDef: 85,
  baseSpeed: 100,
  movimientos: [lanzallamas, garraDragon, ataqueRapido],
);

Pokemon crearHydreigon() => Pokemon(
  nombre: 'Hydreigon',
  tipoPrimario: 'Siniestro',
  baseHP: 92,
  baseAtk: 105,
  baseDef: 90,
  baseSpAtk: 125,
  baseSpDef: 90,
  baseSpeed: 98,
  movimientos: [bolaSombra, psiquico, ataqueRapido],
);

Pokemon crearSpiritomb() => Pokemon(
  nombre: 'Spiritomb',
  tipoPrimario: 'Fantasma',
  baseHP: 50,
  baseAtk: 92,
  baseDef: 108,
  baseSpAtk: 92,
  baseSpDef: 108,
  baseSpeed: 35,
  movimientos: [bolaSombra, pulsoUmbrio, ataqueRapido],
);

Pokemon crearMilotic() => Pokemon(
  nombre: 'Milotic',
  tipoPrimario: 'Agua',
  baseHP: 95,
  baseAtk: 60,
  baseDef: 79,
  baseSpAtk: 100,
  baseSpDef: 125,
  baseSpeed: 81,
  movimientos: [surf, brilloMagico, congelar],
);

Pokemon crearScizor() => Pokemon(
  nombre: 'Scizor',
  tipoPrimario: 'Bicho',
  baseHP: 70,
  baseAtk: 130,
  baseDef: 100,
  baseSpAtk: 55,
  baseSpDef: 80,
  baseSpeed: 65,
  movimientos: [zumbido, garraMetal, golpeCruzado],
);

Pokemon crearStaraptor() => Pokemon(
  nombre: 'Staraptor',
  tipoPrimario: 'Volador',
  baseHP: 85,
  baseAtk: 120,
  baseDef: 70,
  baseSpAtk: 50,
  baseSpDef: 60,
  baseSpeed: 100,
  movimientos: [ataqueAereo, hiperColmillo, golpeCruzado],
);

Pokemon crearGigalith() => Pokemon(
  nombre: 'Gigalith',
  tipoPrimario: 'Roca',
  baseHP: 85,
  baseAtk: 135,
  baseDef: 130,
  baseSpAtk: 60,
  baseSpDef: 80,
  baseSpeed: 25,
  movimientos: [avalancha, terremoto, garraMetal],
);

Pokemon crearSylveon() => Pokemon(
  nombre: 'Sylveon',
  tipoPrimario: 'Hada',
  baseHP: 95,
  baseAtk: 65,
  baseDef: 65,
  baseSpAtk: 110,
  baseSpDef: 130,
  baseSpeed: 60,
  movimientos: [brilloMagico, psiquico, ataqueRapido],
);

Pokemon crearWeavile() => Pokemon(
  nombre: 'Weavile',
  tipoPrimario: 'Hielo',
  baseHP: 70,
  baseAtk: 120,
  baseDef: 65,
  baseSpAtk: 45,
  baseSpDef: 85,
  baseSpeed: 125,
  movimientos: [punioHielo, pulsoUmbrio, garraMetal],
);

Pokemon crearCrobat() => Pokemon(
  nombre: 'Crobat',
  tipoPrimario: 'Veneno',
  baseHP: 85,
  baseAtk: 90,
  baseDef: 80,
  baseSpAtk: 70,
  baseSpDef: 80,
  baseSpeed: 130,
  movimientos: [bombaLodo, ataqueAereo, zumbido],
);

Pokemon crearNinetales() => Pokemon(
  nombre: 'Ninetales',
  tipoPrimario: 'Fuego',
  baseHP: 73,
  baseAtk: 76,
  baseDef: 75,
  baseSpAtk: 81,
  baseSpDef: 100,
  baseSpeed: 100,
  movimientos: [lanzallamas, ascuasEstado, psiquico],
);

// ================================================================
//                        ROSTER DEFAULT
// ================================================================
// Para crear una nueva partida, sacar aleatorios de aquí.
//
// Después vas a crear otro archivo para el roster de 30 finales.
// ================================================================

List<Pokemon> rosterDefault() => [
  crearBulbasaur(),
  crearPikachu(),
  crearCharmander(),
  crearSquirtle(),
  crearGengar(),
  crearAlakazam(),
  crearGarchomp(),
  crearTyranitar(),
  crearMetagross(),
  crearSalamence(),
  crearDragonite(),
  crearGoodra(),
  crearSceptile(),
  crearAggron(),
  crearAbsol(),
  crearArcanine(),
  crearVaporeon(),
  crearDonphan(),
  crearBreloom(),
  crearMagnezone(),
  crearUmbreon(),
  crearSwampert(),
  crearTogekiss(),
  crearFerrothorn(),
  crearInfernape(),
  crearGliscor(),
  crearLucario(),
  crearGardevoir(),
  crearSnorlax(),
  crearGreninja(),
  crearVenusaur(),
  crearBlastoise(),
  crearEspeon(),
  crearTyphlosion(),
  crearFeraligatr(),
  crearMeganium(),
  crearAmpharos(),
  crearHeracross(),
  crearTorterra(),
  crearEmpoleon(),
  crearLuxray(),
  crearRoserade(),
  crearSpiritomb(),
  crearMilotic(),
  crearScizor(),
  crearStaraptor(),
  crearGigalith(),
  crearSylveon(),
  crearWeavile(),
  crearCrobat(),
  crearNinetales(),
];
