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
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.black),
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
                const RegisterTextField(
                  keyboardType: TextInputType.name,
                  hintText: Strings.search,
                ),
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