import 'package:flutter/material.dart';
import 'package:cadetbank/core/res/values/dimens.dart';

class PokemonCard extends StatelessWidget {
  final String? spriteUrl;
  final String? pokemonName;
  final List<String>? types;

  const PokemonCard({
    super.key,
    this.spriteUrl,
    this.pokemonName,
    this.types,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // pokemon sprite box
        Container(
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: spriteUrl != null
              ? Image.network(spriteUrl!, fit: BoxFit.contain)
              : const Center(child: Text('No Pokemon Selected')),
        ),
        const SizedBox(height: Dimens.s20),

        // pokemon name
        Text(
          pokemonName ?? 'Unknown',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: Dimens.s16),

        // pokemon types
        if (types != null && types!.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: types!
                .map((type) => Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: Dimens.s8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.s20,
                          vertical: Dimens.s8,
                        ),
                        decoration: BoxDecoration(
                          color: _getTypeColor(type),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          type,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
      ],
    );
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'normal':
        return const Color(0xFFA8A878);
      case 'fire':
        return const Color(0xFFF08030);
      case 'water':
        return const Color(0xFF6890F0);
      case 'grass':
        return const Color(0xFF78C850);
      case 'electric':
        return const Color(0xFFF8D030);
      case 'ice':
        return const Color(0xFF98D8D8);
      case 'fighting':
        return const Color(0xFFC03028);
      case 'poison':
        return const Color(0xFFA040A0);
      case 'ground':
        return const Color(0xFFE0C068);
      case 'flying':
        return const Color(0xFFA890F0);
      case 'psychic':
        return const Color(0xFFF85888);
      case 'bug':
        return const Color(0xFFA8B820);
      case 'rock':
        return const Color(0xB8A038);
      case 'ghost':
        return const Color(0xFF705898);
      case 'dragon':
        return const Color(0xFF7038F8);
      case 'dark':
        return const Color(0xFF705848);
      case 'steel':
        return const Color(0xFFB8B8D0);
      case 'fairy':
        return const Color(0xFFEE99AC);
      default:
        return const Color(0xFF68A090);
    }
  }
}
