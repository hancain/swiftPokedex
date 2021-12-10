import 'dart:ui';
import 'package:flutter/material.dart';
import 'detailPokemonDataModel.dart';


class detailPokemon extends StatelessWidget{
  final detailPokemonDataModel data;

  const detailPokemon({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.data.name.toUpperCase() + "'S DETAILS"),),
      body: Center( //column
       // heightFactor: 20,
        child: Container (//children: [
            child: Column(
            children: [Image(
                image: NetworkImage(data.image),
                width: 400,
                height: 400,
                fit: BoxFit.fill
            ),
            Text(
              data.id, style: TextStyle(fontSize: 45, fontFamily: 'Courier New')
          ),
            Text(
              data.name[0].toUpperCase() + data.name.substring(1), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45, fontFamily: 'Courier New') //here
            ),
          ],
        )),
      ));
    throw UnimplementedError();
  }
  }

