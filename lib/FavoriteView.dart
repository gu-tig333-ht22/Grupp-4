import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/Filter.dart';
import 'models/movie.dart';
import 'package:template/MovieDetails.dart';

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
          actions: [
            Consumer<MyState>(
                builder: (context, state, child) =>
                    Center(child: Text("TODO"))),
            MenuButton(),
          ],
        ),
        body: Consumer<MyState>(
          builder: (context, state, child) => _favoritelist(
              FilterList.filterList(state.favorite, state.filterBy)),
        ));
  }

  Widget _favoritelist(favorites) {
    var list = List.generate(favorites.length, (index) => favorites[index]);

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

  Widget _item(movie, context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (con) => MovieDetails(movie.id)));
      },
      child: ListTile(
        visualDensity: VisualDensity(vertical: 4),
        leading: _image(movie.poster),
        title: Text(
          movie.title,
          style: TextStyle(fontSize: 20),
        ),
        trailing: IconButton(
          icon: Icon(Icons.favorite),
          color: Colors.red,
          onPressed: () {
            Provider.of<MyState>(context, listen: false)
                .deleteFavorites(movie.id);
          },
        ),
      ),
    );
  }

  Widget _image(poster) {
    return Container(
      height: 90,
      width: 50,
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: poster != null
              ? NetworkImage('https://image.tmdb.org/t/p/w500/$poster')
              : Image.asset('./assets/temp_movie_poster/movieDefualt.jpeg')
                  as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
