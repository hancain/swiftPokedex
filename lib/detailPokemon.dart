import 'dart:ui';
import 'package:flutter/material.dart';
import 'detailPokemonDataModel.dart';


class detailPokemon extends StatelessWidget{
  final detailPokemonDataModel data;

  const detailPokemon({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.data.name.toUpperCase() + "'S DETIALS"),),
      body: Column(
        children: [
            Text(
                data.id
            ),
            Image(
                image: NetworkImage(data.image)
            ),
            Text(
              data.name, style: TextStyle(fontWeight: FontWeight.bold)
            ),
          ],
        ),
      );
    throw UnimplementedError();
  }
  }

