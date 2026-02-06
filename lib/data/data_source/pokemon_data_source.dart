import 'package:dio/dio.dart';

abstract interface class PokemonDataSource {
  Future<Response> getPokemonList({int limit=20, int offset = 0});
  Future<Response> getPokemonDetails(String name);
}