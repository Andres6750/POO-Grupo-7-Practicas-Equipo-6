// lib/ui/widgets/pokemonHudGBA.dart

import 'package:flutter/material.dart';
import '../../models/pokemon.dart';
import 'barraDeVida.dart';

class PokemonHudGBA extends StatelessWidget {
  final Pokemon pokemon;
  final bool esEnemigo;

  const PokemonHudGBA({
    super.key,
    required this.pokemon,
    required this.esEnemigo,
  });

  String _abreviaturaEstado(EstadoAlterado e) {
    switch (e) {
      case EstadoAlterado.paralizado:
        return "PAR";
      case EstadoAlterado.envenenado:
        return "PSN";
      case EstadoAlterado.quemado:
        return "BRN";
      case EstadoAlterado.congelado:
        return "FRZ";
      default:
        return "";
    }
  }

  Color _colorEstado(EstadoAlterado e) {
    switch (e) {
      case EstadoAlterado.paralizado:
        return const Color(0xFFF7D000);
      case EstadoAlterado.envenenado:
        return const Color(0xFF8A2BE2);
      case EstadoAlterado.quemado:
        return const Color(0xFFE4572E);
      case EstadoAlterado.congelado:
        return const Color(0xFF57C7FF);
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black, width: 3),
      ),
      child: Column(
        crossAxisAlignment:
            esEnemigo ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // =========================================================
          //        FILA DE NOMBRE Y ESTADO (se alinean solos)
          // =========================================================
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment:
                esEnemigo ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (esEnemigo && pokemon.estado != EstadoAlterado.ninguno)
                _buildEstado(),

              if (esEnemigo) const SizedBox(width: 8),

              Text(
                pokemon.nombre,
                style: const TextStyle(
                  fontFamily: "PKMN",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              if (!esEnemigo) const SizedBox(width: 8),

              if (!esEnemigo && pokemon.estado != EstadoAlterado.ninguno)
                _buildEstado(),
            ],
          ),

          // Nivel debajo del nombre
          Text(
            "Nv.${pokemon.nivel}",
            style: const TextStyle(
              fontFamily: "PKMN",
              fontSize: 17,
            ),
          ),

          const SizedBox(height: 10),

          // =========================================================
          //                         HP
          // =========================================================
          Text(
            "HP: ${pokemon.hpActual}/${pokemon.hpMaximo}",
            style: const TextStyle(
              fontFamily: "PKMN",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          BarraVida(
            hpActual: pokemon.hpActual,
            hpMax: pokemon.hpMaximo,
          ),
        ],
      ),
    );
  }

  // =========================================================
  //             WIDGET SEPARADO PARA EL ESTADO
  // =========================================================
  Widget _buildEstado() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: _colorEstado(pokemon.estado),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Text(
        _abreviaturaEstado(pokemon.estado),
        style: const TextStyle(
          fontFamily: "PKMN",
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
