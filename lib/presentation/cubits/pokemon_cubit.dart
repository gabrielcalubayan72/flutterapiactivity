import 'package:cadetbank/core/utils/result/result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cadetbank/domain/repositories/pokemon_repository.dart';
import 'package:cadetbank/presentation/cubits/pokemon_state.dart';

class PokemonCubit extends Cubit<PokemonState> {
  final PokemonRepository repository;

  PokemonCubit(this.repository) : super(PokemonInitial());

  Future<void> loadInitialPokemon() async {
    emit(PokemonLoading());
    final result = await repository.getAllPokemon();

    switch (result) {
      case Success(result: final pokemonList):
        emit(PokemonLoaded(pokemonList));
      case Failure(error: final errorMsg):
        emit(PokemonError(errorMsg.toString()));
    }
  }

  Future<void> search(String name) async {
    if (name.isEmpty) return loadInitialPokemon();
    
    emit(PokemonLoading());
    final result = await repository.getPokemonDetails(name);

    switch (result) {
      case Success(result: final pokemon):
        emit(PokemonLoaded([pokemon]));
      case Failure(error: final errorMsg):
        emit(PokemonError(errorMsg.toString()));
    }
  }
}