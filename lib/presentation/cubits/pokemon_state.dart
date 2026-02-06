import 'package:cadetbank/data/models/pokemon/pokemon.dart';

sealed class PokemonState {}

final class PokemonInitial extends PokemonState {}
final class PokemonLoading extends PokemonState {}
final class PokemonLoaded extends PokemonState {
  final List<Pokemon> pokemonList;
  PokemonLoaded(this.pokemonList);
}
final class PokemonError extends PokemonState {
  final String message;
  PokemonError(this.message);
}