import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/models/movie.dart';
import 'package:template/providers/movie_provider.dart';
import 'package:template/widgets/menu_button.dart';
import 'package:template/screens/movie_details.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor:
              const Color(0xFF27272D), // const Color.fromARGB(255, 29, 29, 33),
          title: const Text('Favorites'),
          actions: [
            Consumer<MovieState>(
                builder: (context, state, child) =>
                    Center(child: Text(GenreListMap.genreMap[state.filterBy]))),
            MenuButton(onSelectedFunctionCallback: (value) => Provider.of<MovieState>(context, listen: false).setFilterBy(value),),
          ],
        ),
        body: Consumer<MovieState>(builder: (context, state, child) {
          if (state.favorite.isEmpty) {
            return const Center(child: Text("You have no favorite movies yet."));
          }
          if (FilterList.filterList(state.favorite, state.filterBy).isEmpty) {
            return const Center(
              child: Text("You have no favorite movies of this genre yet."),
            );
          } else {
            return _favoritelist(
                FilterList.filterList(state.favorite, state.filterBy));
          }
        }));
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
            .push(MaterialPageRoute(builder: (con) => MovieDetails(movieId: movie.id)));
      },
      child: ListTile(
        visualDensity: const VisualDensity(vertical: 4),
        leading: _image(movie.poster),
        title: Text(
          movie.title,
          style: const TextStyle(fontSize: 20),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.favorite),
          color: Colors.red,
          onPressed: () {
            Provider.of<MovieState>(context, listen: false)
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
              : Image.asset('./assets/temp_movie_poster/movie_default_poster.jpeg')
                  as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}