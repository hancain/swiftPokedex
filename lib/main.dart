import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/apiFiles/api_helper.dart';
import 'package:pokedex/apiFiles/pokemon_object.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}
class MyHomePageState extends State<MyHomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: pokemonListBuild(),
    );
  }
  Widget pokemonListBuild() {
    return FutureBuilder<List<Pokemon>>(
        future: getAllPokemon(),

        builder: (BuildContext context, snapshot) {
          return ListView.builder(
            itemCount: 151,
            itemBuilder: (context, index){
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text("Error :(");
                }
                return _buildRow(
                    snapshot.data![index]
                );
              }
              else {
                return const CircularProgressIndicator();
              }
            }


          );
        }
      //       FutureBuilder<List<Pokemon>>(
      //         future: getAllPokemon(),
      //         builder: (context, snapshot) {
      //       if (snapshot.connectionState == ConnectionState.done) {
      //         if (snapshot.hasError) {
      //           return const Text("Error :(");
      //         }
      //         return Text(
      //             snapshot.data!.map((pokemon) => pokemon.name).toList().toString());
      //       }
      //       else {
      //         return const CircularProgressIndicator();
      //       }
      //         }),
      //       FutureBuilder<Pokemon>(
      //           future: getPokemon("872"),
      //           builder: (context, snapshot) {
      //             if (snapshot.connectionState == ConnectionState.done){
      //               if (snapshot.hasError){
      //                 return const Text("Error :(");
      //               }
      //               return Image(
      //                   image: NetworkImage(snapshot.data!.sprite.front)
      //               );
      //             }
      //             else {
      //               return const CircularProgressIndicator();
      //             }
      //             }
      // ),
      //    ]
      //);
    );
  }

      Widget _buildRow(Pokemon index) {
      String s = index.name;
      s = s[0].toUpperCase() + s.substring(1);
        return ListTile(
          leading: Image(
            image: NetworkImage(index.sprite.front)
          ),
          title: Text(
              index.id.toString()
          ),
          subtitle: Text(
            s//index.name
          ),

        );
      }

    }
