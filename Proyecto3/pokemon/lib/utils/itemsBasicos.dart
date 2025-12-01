// lib/utils/itemsBasicos.dart

import '../models/item.dart';
import '../models/pokemon.dart';

final mochilaInicial = [
  Item(nombre: "Poción", tipo: TipoItem.curaHP, cantidad: 3, montoHP: 20),
  Item(nombre: "Superpoción", tipo: TipoItem.curaHP, cantidad: 2, montoHP: 50),
  Item(nombre: "Hiperpoción", tipo: TipoItem.curaHP, cantidad: 1, montoHP: 200),

  Item(nombre: "Antídoto", tipo: TipoItem.curaEstado, cantidad: 2, cura: EstadoAlterado.envenenado),
  Item(nombre: "Antiparalizante", tipo: TipoItem.curaEstado, cantidad: 1, cura: EstadoAlterado.paralizado),
  Item(nombre: "Antiquemadura", tipo: TipoItem.curaEstado, cantidad: 1, cura: EstadoAlterado.quemado),
  Item(nombre: "Descongelante", tipo: TipoItem.curaEstado, cantidad: 1, cura: EstadoAlterado.congelado),

  Item(nombre: "Cura Total", tipo: TipoItem.curaEstado, cantidad: 1, cura: EstadoAlterado.ninguno),
];
