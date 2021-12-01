import 'dart:async';

import 'package:pokedex/apiFiles/pokemon_object.dart';
import 'package:pokedex/apiFiles/pokemon_repository.dart';

import 'api_response.dart';

class PokemonBloc{
  late PokemonRepository _pokemonRepository;
  late StreamController _pokemonListController;
  StreamSink<ApiResponse<List<Pokemon>>> get pokemonListSink =>
      _pokemonListController.sink as StreamSink<ApiResponse<List<Pokemon>>>;
  Stream<ApiResponse<List<Pokemon>>> get pokemonListStream =>
      _pokemonListController.stream as Stream<ApiResponse<List<Pokemon>>>;

  PokemonBloc(){
    _pokemonListController = StreamController<ApiResponse<List<Pokemon>>>();
    _pokemonRepository = PokemonRepository();
    fetchPokemonList();
  }

  fetchPokemonList() async {
    pokemonListSink.add(ApiResponse.loading('Fetching Pokemon'));
    try{
      List<Pokemon> pokemon = await
          _pokemonRepository.fetchPokemonList();
      pokemonListSink.add(ApiResponse.completed(pokemon));
    }
    catch(e){
      pokemonListSink.add(ApiResponse.error(e.toString()));
    }
  }
}