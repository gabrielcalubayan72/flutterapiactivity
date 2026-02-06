import 'package:cadetbank/core/utils/result/result.dart';
import 'package:cadetbank/data/models/pokemon/pokemon.dart';

abstract interface class PokemonRepository {
  Future<Result<List<Pokemon>>> getAllPokemon({int limit = 20, int offset = 0});
  Future<Result<Pokemon>> getPokemonDetails(String name);
}