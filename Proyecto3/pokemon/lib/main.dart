import 'package:flutter/material.dart';
import 'ui/screens/pantalla_inicio.dart';

void main() {
  runApp(const MyPokemonGame());
}

class MyPokemonGame extends StatelessWidget {
  const MyPokemonGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pokémon Edición FI",
      debugShowCheckedModeBanner: false,
      home: const PantallaInicio(),
    );
  }
}
