import 'package:flutter/material.dart';
import 'package:cadetbank/core/res/values/dimens.dart';

class PokemonCard extends StatelessWidget {
  final String? spriteUrl;
  final String? pokemonName;
  final List<String>? types;

  const PokemonCard({
    Key? key,
    this.spriteUrl,
    this.pokemonName,
    this.types,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Pokemon Sprite Box
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

        // Pokemon Name
        Text(
          pokemonName ?? 'Unknown',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: Dimens.s16),

        // Pokemon Types
        if (types != null && types!.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: types!
                .map((type) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimens.s8),
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
      case 'grass':
        return const Color(0xFF78C850);
      case 'poison':
        return const Color(0xFFA040A0);
      case 'fire':
        return const Color(0xFFF08030);
      case 'water':
        return const Color(0xFF6890F0);
      default:
        return Colors.grey;
    }
  }
}