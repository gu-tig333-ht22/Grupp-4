import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        visualDensity: VisualDensity(horizontal: 2.0, vertical: 2.0),
      ),
      home: Mainview(),
    );
  }
}

class Mainview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorites",
          style: GoogleFonts.oswald(
            fontSize: 30,
          ),
        ),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back,
              color: Color.fromRGBO(2, 150, 229, 100)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: _list(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Watchlist',
          ),
        ],
      ),
    );
  }

  Widget _list() {
    var favorites = [
      "Forrest Gump",
      "The Godfather",
      "Parasite",
      "The Square",
      "Turist",
      "Seven",
    ];

    var list =
        List.generate(favorites.length, (index) => "${favorites[index]}");

    return ListView.builder(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: kFloatingActionButtonMargin + 45,
      ),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            _item(list[index]),
            const Divider(height: 10, thickness: 1),
          ],
        );
      },
    );
  }

  Widget _item(text) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(fontSize: 20),
      ),
      trailing: IconButton(
        icon: Icon(Icons.favorite),
        color: Colors.red,
        onPressed: () {},
      ),
    );
  }
}
