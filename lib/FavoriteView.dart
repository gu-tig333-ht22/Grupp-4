import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         brightness: Brightness.dark,
//         visualDensity: VisualDensity(horizontal: 2.0, vertical: 2.0),
//       ),
//       home: Mainview(),
//     );
//   }
// }

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

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
      ),
      body: _favoritelist(),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home_outlined),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.favorite_border),
      //       label: 'Favorites',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.bookmark_border),
      //       label: 'Watchlist',
      //     ),
      //   ],
      // ),
    );
  }

  Widget _favoritelist() {
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
