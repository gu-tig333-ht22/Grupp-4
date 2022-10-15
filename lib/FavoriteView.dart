import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'models/movie.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 29, 29, 33),
          title: Center(
            child: Text('Favorites'),
          ),
        ),
        body: Consumer<MyState>(
          builder: ((context, state, child) => _favoritelist(state.favorite)),
        ));
  }

  Widget _favoritelist(favorites) {
    var list =
        List.generate(favorites.length, (index) => "${favorites[index].title}");

    return ListView.builder(
      padding: const EdgeInsets.only(
        top: 20,
      ),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            _item(list[index], context),
            const Divider(height: 10, thickness: 1),
          ],
        );
      },
    );
  }

  Widget _item(text, context) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(fontSize: 20),
      ),
      trailing: IconButton(
        icon: Icon(Icons.favorite),
        color: Colors.red,
        onPressed: () {
          Provider.of<MyState>(context, listen: false).deleteFavorites();
        },
      ),
    );
  }
}
