// lib/models/movimiento.dart

// Categoría de movimiento:
// - fisico: usa ataque / defensa
// - especial: usa ataque especial / defensa especial
// - estado: no hace daño directo
enum CategoriaMovimiento { fisico, especial, estado }

class Movimiento {
  final String nombre;
  final String tipo; // Debe coincidir con las claves de tabla_de_tipos (ej. 'Fuego', 'Agua')
  final CategoriaMovimiento categoria;
  final int poder;       // poder = 0 indica movimiento de estado (sin daño directo por ahora)
  final int precision;   // 0-100
  final int prioridad;   // como en Pokémon (-6 a +6). 0 por defecto

  const Movimiento({
    required this.nombre,
    required this.tipo,
    required this.categoria,
    required this.poder,
    required this.precision,
    required this.prioridad,
  });

  @override
  String toString() {
    final cat = categoria == CategoriaMovimiento.fisico
        ? 'Físico'
        : (categoria == CategoriaMovimiento.especial ? 'Especial' : 'Estado');
    return '$nombre ($tipo • $cat) PDR:$poder PCS:$precision PRIO:$prioridad';
  }
}
