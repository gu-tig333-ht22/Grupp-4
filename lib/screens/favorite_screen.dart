import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/models/movie.dart';
import 'package:template/providers/movie_provider.dart';
import 'package:template/widgets/menu_button.dart';
import 'package:template/widgets/movie_favorite_item.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF27272D),
        title: const Text('My Favorites'),
        actions: [
          Consumer<MovieState>(
              builder: (context, state, child) =>
                  Center(child: Text(GenreListMap.genreMap[state.filterBy]))),
          MenuButton(
            onSelectedFunctionCallback: (value) =>
                Provider.of<MovieState>(context, listen: false)
                    .setFilterBy(value),
          ),
        ],
      ),
      body: Consumer<MovieState>(
        builder: (context, state, child) {
          if (state.favorite.isEmpty) {
            return const Center(
                child: Text("You have no favorite movies yet."));
          }
          if (FilterList.filterList(state.favorite, state.filterBy).isEmpty) {
            return const Center(
              child: Text("You have no favorite movies of this genre yet."),
            );
          } else {
            return _favoritelist(
                FilterList.filterList(state.favorite, state.filterBy));
          }
        },
      ),
    );
  }

  Widget _favoritelist(List<Movie> favorites) {
    var list = List.generate(favorites.length, (index) => favorites[index]);

    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 1 / 1.4),
      padding: const EdgeInsets.only(
        top: 20,
      ),
      children: <Widget>[
        ...list.map(
          (movie) => MovieFavoriteItem(movie: movie),
        )
      ],
    );
  }
}
