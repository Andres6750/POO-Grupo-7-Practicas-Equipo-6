// lib/models/item.dart

import '../models/pokemon.dart';

enum TipoItem {
  curaHP,
  curaEstado,
  revivir,
}

class Item {
  final String nombre;
  final TipoItem tipo;
  int cantidad;
  final int? montoHP;
  final EstadoAlterado? cura;

  Item({
    required this.nombre,
    required this.tipo,
    required this.cantidad,
    this.montoHP,
    this.cura,
  });
}
