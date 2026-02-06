import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cadetbank/core/res/values/dimens.dart';
import 'package:cadetbank/presentation/cubits/pokemon_cubit.dart';
import 'package:cadetbank/presentation/cubits/pokemon_state.dart';
import 'package:cadetbank/presentation/screens/registration/widgets/pokemon_card.dart';
import 'package:cadetbank/presentation/screens/registration/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cadetbank/presentation/screens/registration/widgets/register_text_field.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.s20),
          child: Column(
            children: [
              const SizedBox(height: Dimens.s20),
              SearchTextField(
                hintText: "Search Pokémon by name...",
                onSubmitted: (value) {
                  context.read<PokemonCubit>().search(value);
                },
              ),
              const SizedBox(height: Dimens.s20),

              Expanded(
                child: BlocBuilder<PokemonCubit, PokemonState>(
                  builder: (context, state) {
                    if (state is PokemonLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is PokemonError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    if (state is PokemonLoaded) {
                      if (state.pokemonList.isEmpty) {
                        return const Center(child: Text("No Pokémon found."));
                      }

                      return ListView.separated(
                        itemCount: state.pokemonList.length,
                        padding: const EdgeInsets.only(bottom: Dimens.s20),
                        separatorBuilder: (_, __) => const SizedBox(height: 40),
                        itemBuilder: (context, index) {
                          final pokemon = state.pokemonList[index];
                          
                          return PokemonCard(
                            pokemonName: pokemon.name,
                            spriteUrl: pokemon.spriteUrl,
                            types: pokemon.types,
                          );
                        },
                      );
                    }

                    // Initial state (before search/load)
                    return const Center(
                      child: Text("Welcome! Search for a Pokémon to begin."),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
