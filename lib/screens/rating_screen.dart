import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:template/models/movie.dart';
import 'package:template/providers/movie_provider.dart';
import 'movie_details.dart';
import 'package:template/widgets/sort_button.dart';

class RatingScreen extends StatelessWidget {
  const RatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Consumer<MovieState>(
            builder: (context, state, child) => SortButton(
                onSelectedFunctionCallback: (value) =>
                    Provider.of<MovieState>(context, listen: false)
                        .setratingFilterBy(value))),
        title: Text(
          "My Ratings",
        ),
        backgroundColor: const Color(0xFF27272D),
      ),
      body: Consumer<MovieState>(builder: (context, state, child) {
        if (state.ratedMovies.isEmpty) {
          return const Center(
              child: Text("You have not rated any movies yet."));
        } else {
          return _ratingList(
              sortedList(state.ratedMovies, state.ratingFilterBy), state);
        }
      }),
    );
  }

  Widget _ratingList(List<Movie> rateList, MovieState state) {
    List<Movie> list =
        List.generate(rateList.length, (index) => rateList[index]);
    return ListView.builder(
      padding: const EdgeInsets.only(
        top: 20,
      ),
      itemCount: rateList.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            Dismissible(
                direction: DismissDirection.endToStart,
                key: UniqueKey(),
                background: Container(
                  color: Colors.red,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          Provider.of<MovieState>(context, listen: false)
                              .deleteRating(list[index].id);
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                      ),
                    ),
                  ),
                ),
                confirmDismiss: (direction) async {
                  bool delete = true;
                  final snackBarController =
                      ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 5),
                      margin: const EdgeInsets.only(bottom: 10),
                      behavior: SnackBarBehavior.floating,
                      clipBehavior: Clip.hardEdge,
                      elevation: 4,
                      backgroundColor: const Color(0xFF27272D),
                      content: Text('Deleted ${list[index].title}',
                          style: const TextStyle(color: Colors.white)),
                      action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () => delete = false,
                          textColor: Colors.white),
                    ),
                  );
                  await snackBarController.closed;
                  return delete;
                },
                onDismissed: (_) {
                  Provider.of<MovieState>(context, listen: false)
                      .deleteRating(list[index].id);
                },
                child: _item(list[index], context, state)),
            const Divider(height: 10, thickness: 1),
          ],
        );
      },
    );
  }

  Widget _item(Movie movie, BuildContext context, MovieState state) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (con) => MovieDetails(movieId: movie.id)));
      },
      child: ListTile(
        visualDensity: const VisualDensity(vertical: 4),
        leading: _image(movie.poster),
        title: Text(
          movie.title,
          style: const TextStyle(fontSize: 20),
        ),
        trailing: RatingBar.builder(
          ignoreGestures: true,
          unratedColor: const Color.fromARGB(255, 29, 29, 33),
          itemSize: 28,
          initialRating: movieInRatedMovies(state.ratedMovies, movie) / 2,
          minRating: 0.5,
          maxRating: 10,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.white,
          ),
          onRatingUpdate: (rating) {
            Provider.of<MovieState>(context, listen: false)
                .postRating(movie.id, rating * 2);
          },
        ),
      ),
    );
  }

  Widget _image(String? poster) {
    return Container(
      height: 90,
      width: 50,
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: poster != null
              ? NetworkImage('https://image.tmdb.org/t/p/w500/$poster')
              : const AssetImage('./assets/movie_default_poster.jpeg')
                  as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  double movieInRatedMovies(List<Movie> list, Movie movie) {
    for (var i = 0; i < list.length; i++) {
      if (movie.id == list[i].id) {
        double value = list[i].ownRating;
        return value;
      }
    }
    return 0;
  }

  List<Movie> sortedList(List<Movie> list, order) {
    if (order == 0) {
      return list;
    } else if (order == 1) {
      list.sort((b, a) => a.ownRating.compareTo(b.ownRating));
    } else if (order == 2) {
      list.sort((a, b) => a.ownRating.compareTo(b.ownRating));
    }
    return list;
  }
}
