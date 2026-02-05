import 'package:cadetbank/core/res/values/dimens.dart';
import 'package:cadetbank/core/res/values/strings.dart';
import 'package:cadetbank/presentation/screens/registration/widgets/back_button.dart';
import 'package:cadetbank/presentation/screens/registration/widgets/pokemon_card.dart';
import 'package:cadetbank/presentation/screens/registration/widgets/register_text_field.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.s20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: Strings.pokepedia,
                        style: TextStyle(
                          fontSize: Theme.of(context).textTheme.headlineLarge?.fontSize,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Dimens.s20),
                
                // --- ALIGNED SEARCH SECTION WITH GAP ---
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center, // Matches button height to TextField
                    children: [
                      const Expanded(
                        child: RegisterTextField(
                          keyboardType: TextInputType.name,
                          hintText: Strings.search,
                        ),
                      ),
                      const SizedBox(width: Dimens.s10), // Your desired gap
                      AspectRatio(
                        aspectRatio: 1, // Ensures the button is a square matching the height
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(Dimens.s12),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: IconButton(
                            constraints: const BoxConstraints(), // Removes default 48px min-size
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              // Search Logic
                            },
                            icon: const Icon(
                              Icons.search,
                              size: 20, 
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // --- END SEARCH SECTION ---

                const SizedBox(height: Dimens.s20),
                const PokemonCard(
                  pokemonName: 'Bulbasaur',
                  types: ['Grass', 'Poison'],
                  spriteUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    bottomNavigationBar: const Padding(
      padding: EdgeInsets.all(Dimens.s20),
      child: BackButtonSearch()
    )
  );
}