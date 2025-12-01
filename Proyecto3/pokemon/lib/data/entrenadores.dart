import 'roster.dart';
import '../models/pokemon.dart';

class EntrenadorData {
  final String nombre;
  final String sprite;          
  final List<Pokemon> equipo;

  EntrenadorData({
    required this.nombre,
    required this.sprite,
    required this.equipo,
  });
}

// =============================================================
//                    DEFINICIONES INDIVIDUALES
// =============================================================

// ABDIEL
final EntrenadorData entrenadorAbdiel = EntrenadorData(
  nombre: "Abdiel",
  sprite: "abdiel.png",
  equipo: [
    crearGarchomp(),
    crearTyranitar(),
    crearDragonite(),
    crearMetagross(),
    crearHydreigon(),
    crearGoodra(),
  ],
);

// OSWALDO
final EntrenadorData entrenadorOswaldo = EntrenadorData(
  nombre: "Oswaldo",
  sprite: "oswaldo.png",
  equipo: [
    crearArcanine(),
    crearVaporeon(),
    crearDonphan(),
    crearBreloom(),
    crearMagnezone(),
    crearUmbreon(),
  ],
);

// ANDRES
final EntrenadorData entrenadorAndres = EntrenadorData(
  nombre: "Andres",
  sprite: "andres.png",
  equipo: [
    crearMetagross(),
    crearSwampert(),
    crearTogekiss(),
    crearFerrothorn(),
    crearInfernape(),
    crearGliscor(),
  ],
);

// ALAN
final EntrenadorData entrenadorAlan = EntrenadorData(
  nombre: "Alan",
  sprite: "alan.png",
  equipo: [
    crearCharizard(),
    crearTyranitar(),
    crearGengar(),
    crearDragonite(),
    crearLucario(),
    crearGardevoir(),
  ],
);

// ROBERTO
final EntrenadorData entrenadorRoberto = EntrenadorData(
  nombre: "Roberto",
  sprite: "roberto.png",
  equipo: [
    crearSceptile(),
    crearAlakazam(),
    crearSalamence(),
    crearAggron(),
    crearAbsol(),
    crearNinetales(),
  ],
);

// =============================================================
//                CAMPEONES / PERSONAJES OFICIALES
// =============================================================

// ASH
final EntrenadorData entrenadorAsh = EntrenadorData(
  nombre: "Ash",
  sprite: "ash.png",
  equipo: [
    crearPikachu(),
    crearCharizard(),
    crearBulbasaur(),
    crearSquirtle(),
    crearSnorlax(),
    crearGreninja(),
  ],
);

// ROJO
final EntrenadorData entrenadorRojo = EntrenadorData(
  nombre: "Rojo",
  sprite: "rojo.png",
  equipo: [
    crearPikachu(),
    crearCharizard(),
    crearVenusaur(),
    crearBlastoise(),
    crearSnorlax(),
    crearEspeon(),
  ],
);

// ETHAN (Oro)
final EntrenadorData entrenadorEthan = EntrenadorData(
  nombre: "Ethan",
  sprite: "ethan.png",
  equipo: [
    crearTyphlosion(),
    crearFeraligatr(),
    crearMeganium(),
    crearAmpharos(),
    crearHeracross(),
    crearTyranitar(),
  ],
);

// CYNTHIA / SINNOH
final EntrenadorData entrenadorSinnoh = EntrenadorData(
  nombre: "Cynthia",
  sprite: "cynthia.png",
  equipo: [
    crearSpiritomb(),
    crearRoserade(),
    crearTogekiss(),
    crearLucario(),
    crearMilotic(),
    crearGarchomp(),
  ],
);