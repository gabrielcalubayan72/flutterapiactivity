import 'package:cadetbank/core/res/values/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:cadetbank/data/data_source/pokemon_data_source.dart';

class PokemonRemoteDataSourceImpl implements PokemonDataSource {
  final Dio dio;
  PokemonRemoteDataSourceImpl(this.dio);

  @override
  Future<Response> getPokemonDetails(String name) {
    return dio.get('${Endpoints.pokemon}${name.toLowerCase()}');
  }

  @override
  Future<Response> getPokemonList({int limit = 20, int offset = 0}) async {
    return await dio.get(
      Endpoints.pokemon,
    );
  }
}