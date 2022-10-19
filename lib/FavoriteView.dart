import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'models/movie.dart';
import 'package:template/widgets/shimmer_loader.dart';
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
            PopupMenuButton(
                color: Colors.black,
                onSelected: (int genreId) {
                  Provider.of<MyState>(context, listen: false)
                      .setFilterBy(genreId);
                },
                itemBuilder: (context) => [
                      PopupMenuItem(child: Text('All'), value: 0),
                      PopupMenuItem(child: Text('Action'), value: 28),
                      PopupMenuItem(child: Text('Adventure'), value: 12),
                      PopupMenuItem(child: Text('Comedy'), value: 35),
                      PopupMenuItem(child: Text('Drama'), value: 18),
                      PopupMenuItem(child: Text('Fantasy'), value: 14),
                      PopupMenuItem(child: Text('Horror'), value: 27),
                      PopupMenuItem(child: Text('Romance'), value: 10749),
                      PopupMenuItem(child: Text('Science Fiction'), value: 878),
                      PopupMenuItem(child: Text('Thriller'), value: 53),
                    ]),
          ],
        ),
        body: Consumer<MyState>(
          builder: (context, state, child) =>
              _favoritelist(_filterList(state.favorite, state.filterBy)),
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

  List<Movie> _filterList(list, value) {
    if (value == 0) return list;
    if (value == 28) {
      return list.where((movie) => movie.genreId == 28).toList();
    }
    if (value == 12) {
      return list.where((movie) => movie.genreId == 12).toList();
    }
    if (value == 35) {
      return list.where((movie) => movie.genreId == 35).toList();
    }
    if (value == 18) {
      return list.where((movie) => movie.genreId == 18).toList();
    }
    if (value == 14) {
      return list.where((movie) => movie.genreId == 14).toList();
    }
    if (value == 27) {
      return list.where((movie) => movie.genreId == 27).toList();
    }
    if (value == 10749) {
      return list.where((movie) => movie.genreId == 10749).toList();
    }
    if (value == 878) {
      return list.where((movie) => movie.genreId == 878).toList();
    } else if (value == 53) {
      return list.where((movie) => movie.genreId == 53).toList();
    }

    return list;
  }
}
