class Pokemon {
    int id;
    String name;
    String sprite;
    List<String> types;

    Pokemon({required this.id, required this.name, required this.sprite, required this.types});

    factory Pokemon.fromJson(Map<String, dynamic> json) {
        return Pokemon(
            id: json['id'],
            name: json['name'],
            sprite: json['sprite'],
            types: json['types'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['id'] = id;
        data['name'] = name;
        data['sprites'] = sprite;
        data['types'] = types.map((v) => v).toList();
        return data;
    }
}