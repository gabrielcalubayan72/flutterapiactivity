import 'package:cadetbank/core/res/errors/error.dart';
import 'package:cadetbank/core/utils/result/result.dart';
import 'package:cadetbank/data/data_source/pokemon_data_source.dart';
import 'package:cadetbank/data/models/pokemon/pokemon.dart';
import 'package:cadetbank/domain/repositories/pokemon_repository.dart';
import 'package:dio/dio.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonDataSource dataSource;
  PokemonRepositoryImpl(this.dataSource);

  @override
  Future<Result<List<Pokemon>>> getAllPokemon({int limit = 20, int offset = 0}) async {
    try {
      final response = await dataSource.getPokemonList(limit: limit, offset: offset);
      final List results = response.data['results'];

      final pokemonFutures = results.map((item) {
        return getPokemonDetails(item['name']);
      }).toList();

      final List<Result<Pokemon>> detailResults = await Future.wait(pokemonFutures);

      final List<Pokemon> pokemonList = detailResults
          .whereType<Success<Pokemon>>()
          .map((s) => s.result)
          .toList();

      return Success(pokemonList);
    } catch (_) {
      return Failure(const DefaultError());
    }
  }

  @override
  Future<Result<Pokemon>> getPokemonDetails(String name) async {
    try {
      final response = await dataSource.getPokemonDetails(name);
      final pokemon = Pokemon.fromJson(response.data);
      
      return Result.success(pokemon);
    } catch (_) {
      return Failure(const DefaultError());
    }
  }
}