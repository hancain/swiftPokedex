import 'package:pokedex/apiFiles/api_helper.dart';
import 'package:pokedex/apiFiles/pokemon_object.dart';

class PokemonRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();
  Future<List<Pokemon>> fetchPokemonList() async{
    List<Pokemon> monList = [];
    for(int i = 1; i < 5; i++) {
      final response = await _helper.get("pokemon/" + i.toString());
      monList.add(response);
    }
    return monList;
  }
}