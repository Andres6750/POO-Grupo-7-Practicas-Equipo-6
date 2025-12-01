// lib/utils/tablaDeTipos.dart

// Tabla de efectividades
// 2.0 = súper eficaz
// 0.5 = poco eficaz
// 0.0 = no afecta
// 1.0 = neutral

final Map<String, Map<String, double>> tablaEfectividad = {
  'Normal': {
    'Roca': 0.5,
    'Fantasma': 0.0,
    'Acero': 0.5,
  },
  'Fuego': {
    'Fuego': 0.5,
    'Agua': 0.5,
    'Planta': 2.0,
    'Hielo': 2.0,
    'Bicho': 2.0,
    'Roca': 0.5,
    'Dragón': 0.5,
    'Acero': 2.0,
  },
  'Agua': {
    'Fuego': 2.0,
    'Agua': 0.5,
    'Planta': 0.5,
    'Tierra': 2.0,
    'Roca': 2.0,
    'Dragón': 0.5,
  },
  'Eléctrico': {
    'Agua': 2.0,
    'Planta': 0.5,
    'Eléctrico': 0.5,
    'Tierra': 0.0,
    'Volador': 2.0,
    'Dragón': 0.5,
  },
  'Planta': {
    'Fuego': 0.5,
    'Agua': 2.0,
    'Planta': 0.5,
    'Tierra': 2.0,
    'Roca': 2.0,
    'Volador': 0.5,
    'Bicho': 0.5,
    'Dragón': 0.5,
    'Acero': 0.5,
  },
  'Hielo': {
    'Fuego': 0.5,
    'Agua': 0.5,
    'Planta': 2.0,
    'Hielo': 0.5,
    'Tierra': 2.0,
    'Volador': 2.0,
    'Dragón': 2.0,
    'Acero': 0.5,
  },
  'Lucha': {
    'Normal': 2.0,
    'Hielo': 2.0,
    'Roca': 2.0,
    'Siniestro': 2.0,
    'Acero': 2.0,
    'Veneno': 0.5,
    'Volador': 0.5,
    'Psíquico': 0.5,
    'Bicho': 0.5,
    'Fantasma': 0.0,
    'Hada': 0.5,
  },
  'Veneno': {
    'Planta': 2.0,
    'Hada': 2.0,
    'Veneno': 0.5,
    'Tierra': 0.5,
    'Roca': 0.5,
    'Fantasma': 0.5,
    'Acero': 0.0,
  },
  'Tierra': {
    'Fuego': 2.0,
    'Eléctrico': 2.0,
    'Planta': 0.5,
    'Veneno': 2.0,
    'Roca': 2.0,
    'Volador': 0.0,
    'Acero': 2.0,
  },
  'Volador': {
    'Planta': 2.0,
    'Eléctrico': 0.5,
    'Roca': 0.5,
    'Bicho': 2.0,
    'Lucha': 2.0,
  },
  'Psíquico': {
    'Lucha': 2.0,
    'Veneno': 2.0,
    'Psíquico': 0.5,
    'Siniestro': 0.0,
    'Acero': 0.5,
  },
  'Bicho': {
    'Planta': 2.0,
    'Psíquico': 2.0,
    'Siniestro': 2.0,
    'Fuego': 0.5,
    'Lucha': 0.5,
    'Veneno': 0.5,
    'Volador': 0.5,
    'Fantasma': 0.5,
    'Acero': 0.5,
    'Hada': 0.5,
  },
  'Roca': {
    'Fuego': 2.0,
    'Hielo': 2.0,
    'Volador': 2.0,
    'Bicho': 2.0,
    'Lucha': 0.5,
    'Tierra': 0.5,
    'Acero': 0.5,
  },
  'Fantasma': {
    'Fantasma': 2.0,
    'Psíquico': 2.0,
    'Normal': 0.0,
    'Siniestro': 0.5,
  },
  'Dragón': {
    'Dragón': 2.0,
    'Acero': 0.5,
    'Hada': 0.0,
  },
  'Siniestro': {
    'Psíquico': 2.0,
    'Fantasma': 2.0,
    'Lucha': 0.5,
    'Siniestro': 0.5,
    'Hada': 0.5,
  },
  'Acero': {
    'Hielo': 2.0,
    'Roca': 2.0,
    'Hada': 2.0,
    'Fuego': 0.5,
    'Agua': 0.5,
    'Eléctrico': 0.5,
    'Acero': 0.5,
  },
  'Hada': {
    'Lucha': 2.0,
    'Dragón': 2.0,
    'Siniestro': 2.0,
    'Fuego': 0.5,
    'Veneno': 0.5,
    'Acero': 0.5,
  },
};

/// Devuelve la efectividad de tipoAtaque sobre tipoObjetivo (1.0 si no está en la tabla).
double efectividad(String tipoAtaque, String tipoObjetivo) {
  final mapa = tablaEfectividad[tipoAtaque];
  if (mapa == null) return 1.0;
  return mapa[tipoObjetivo] ?? 1.0;
}

/// Mensaje visual + texto según la efectividad
Map<String, String> descripcionEfectividad(double val) {
  if (val == 2.0) {
    return {'texto': '¡Es súper eficaz!'};
  } else if (val == 0.5) {
    return {'texto': 'No es muy eficaz...'};
  } else if (val == 0.0) {
    return {'texto': 'No surte efecto...'};
  } else {
    return {'texto': ''};
  }
}
