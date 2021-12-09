import 'package:flutter/material.dart';
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}
class MyHomePageState extends State<MyHomePage> {
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Icon searchIcon = const Icon(
      Icons.search); //creates an icon that looks like magnifying glass
  Widget searchBar = const Text("Pokedex");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( //searchbar stuff begins here --------------------------
        title: searchBar,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (searchIcon.icon == Icons.search) {
                  searchIcon = const Icon(Icons.cancel);
                  searchBar = ListTile(
                    //try making this an icon button and attach onPress search operation
                    leading: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 28,
                    ),
                    //leading: const Icon(Icons.search, color: Colors.white, size: 28),
                    title: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'type in monster name...',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                        border: InputBorder.none,
                      ),
                      onSubmitted: (String value) async {
                        await showDialog<void>(
                        context: context,
                        builder: (BuildContext context){
                          return AlertDialog(
                            title: const Text('Results: '),
                            content: _getSearch(value),
                              actions: <Widget>[
                                TextButton(
                                onPressed: () {
                                Navigator.pop(context);
                                },
                                child: const Text('OK'),
                          ),
                          ],);
                        });
                      },
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                } else {
                  searchIcon = const Icon(Icons.search);
                  searchBar = const Text('Pokedex');
                }
              });
            },
            icon: searchIcon,
          )
        ],
        centerTitle: true,
      ), //searchbar stuff ends here ---------------------------
      body: pokemonListBuild(),
    );
  }

  Widget pokemonListBuild() {
    return FutureBuilder<List<Pokemon>>(
        future: getAllPokemon(),
        builder: (BuildContext context, snapshot) {
          return ListView.builder(
              itemCount: 151,
              itemBuilder: (context, index) {
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

  Widget _getSearch(String name){
    return FutureBuilder<Pokemon>(
        future: getPokemonByName(name),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done){
            if (snapshot.hasError){
              return const Text("Error :(");
            }
            if(snapshot.data != null) {
              return _buildRow(snapshot.data!);
            }
            return const Text("Error :(");
          }
          else {
            return const CircularProgressIndicator();
          }
        });
  }

  Widget _buildRow(Pokemon index) {
    String s = index.name;
    s = s[0].toUpperCase() + s.substring(1);
    return ListTile(
      leading: Image(
          image: NetworkImage(index.sprite.front)
      ),
      title: Text(
          index.dexNum.toString()
      ),
      subtitle: Text(
          s //index.name
      ),

    );
  }


}