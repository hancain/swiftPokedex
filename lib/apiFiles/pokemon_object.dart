import 'dart:convert';

Pokemon pokemonFromJson(String str){
    final jsonData = json.decode(str);
    return Pokemon.fromJson(jsonData);
}

List<Pokemon> allPokemonFromJson(String str) {
    final jsonData = json.decode(str);
    return List<Pokemon>.from(jsonData.map((x) => Pokemon.fromJson(x)));
}

class Pokemon {
    int id;
    String name;
    Sprite sprite;
    //List<Type> types;

    Pokemon({
        required this.id,
        required this.name,
        required this.sprite,
        //required this.types,
    });

    factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        id: json["id"],
        name: json["name"],
        sprite: Sprite.fromJson(json["sprites"]),
        //types: json["types"].map((type) => Type.fromJson(json["type"])).toList()
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sprite": sprite,
        //"types": types
    };
}

class Type{
    String name;
    
    Type({
        required this.name,
    });
    
    factory Type.fromJson(Map<String, dynamic> json) => Type(
        name: json["name"]
    );
}

class Sprite{
    String front;

    Sprite({
        required this.front
    });

    factory Sprite.fromJson(Map<String, dynamic> json) => Sprite(
        front: json["front_default"]
    );
}