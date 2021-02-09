import 'dart:io';
import 'dart:convert';

import 'database_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import 'package:shiny_chances/Model/pokemon.dart';

class NetworkHelper {
  final dbHelper = DatabaseHelper();
  final pokeApi = 'https://pokeapi.co/api/v2/pokemon/';

  Future<void> populateDatabase() async {}

  Future<List<Pokemon>> getPokemon(List<int> ids) async {
    List<Pokemon> pokemons = [];
    for (int i = 0; i < ids.length; i++) {
      final response = await http.get('$pokeApi${ids[i]}');
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final pokemon = Pokemon.fromJson(data);
        pokemons.add(pokemon);
      }
    }
  }
}
