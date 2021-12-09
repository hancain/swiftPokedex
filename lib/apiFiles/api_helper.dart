import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'package:pokedex/apiFiles/pokemon_object.dart';

const maxNum = 151;
String url = 'https://pokeapi.co/api/v2/pokemon/';

Future<List<Pokemon>> getAllPokemon() async {
  http.Response response;
  List<Pokemon> pokemonList = [];
  for(int i = 1; i <= maxNum; i++) {
    response = await http.get(Uri.parse(url + i.toString()));
    pokemonList.add(pokemonFromJson(response.body));
  }
  return pokemonList;
}

Future<Pokemon> getPokemon(String i) async{
  final response = await http.get(Uri.parse(url + i));
  return pokemonFromJson(response.body);
}

Future<Pokemon> getPokemonByName(String i) async{
  final response = await http.get(Uri.parse(url + i));
  return pokemonFromJson(response.body);
}

