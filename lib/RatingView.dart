import 'package:flutter/material.dart';
import 'package:flutter/src/material/icons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.grey,
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
          "Ratings",
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
            icon: Icon(Icons.watch_later),
            label: 'watchlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rate_review),
            label: 'Ratings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }

  Widget _list() {
    var ratings = [
      "Nyckeln till frihet (1994)",
      "Blonde (2022)",
      "Smile (2022)",
      "The godfather (1972)",
      "The tourist (2010)",
      "schindler's List (1993)",
      "Forrest Gump (1994)",
      "Fight club (1999)",
      "Inception (2010)",
      "The Pianist (2002)",
      "The Lionking (1994)",
      "Wall-E (2008)",
    ];
    

    var list = List.generate(ratings.length, (index) => "${ratings[index]}");

    return ListView.builder(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: kFloatingActionButtonMargin + 45,
      ),
      itemCount: ratings.length,
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
  RatingBar( 
    minRating: 1,
    maxRating: 5,
    initialRating: 3,
    allowHalfRating: true,
    onRatingUpdate: _saveRating,
    updateOnDrag: true,
)
class _saveRating

  Widget _item(text) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(fontSize: 20),
      ),
      trailing: IconButton(
        icon: Icon(Icons.star),
        color: Colors.yellow,
        onPressed: () {},
      ),
    );
  }
}

class GoogleFonts {
  static oswald({required int fontSize}) {}
}
