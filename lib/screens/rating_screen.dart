import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/models/movie.dart';
import 'package:template/providers/movie_provider.dart';
import 'package:template/widgets/movie_rating_item.dart';
import 'package:template/widgets/sort_button.dart';

class RatingScreen extends StatelessWidget {
  const RatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Consumer<MovieState>(
              builder: (context, state, child) => SortButton(
                  onSelectedFunctionCallback: (value) =>
                      Provider.of<MovieState>(context, listen: false)
                          .setratingFilterBy(value))),
        ],
        title: const Text(
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
    return StatefulBuilder(builder: (context, setState) {
      return ListView(
          padding: const EdgeInsets.only(
            top: 20,
          ),
          children: [
            ...rateList.asMap().entries.map(
                  (movie) => Column(
                    children: <Widget>[
                      Dismissible(
                        direction: DismissDirection.endToStart,
                        key: UniqueKey(),
                        background: Container(
                          color: Colors.red,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  Provider.of<MovieState>(context,
                                          listen: false)
                                      .deleteRating(movie.value.id);
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
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
                              content: Text('Deleted ${movie.value.title}',
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
                          setState(() {
                            rateList.remove(movie.value);
                          });
                          Provider.of<MovieState>(context, listen: false)
                              .deleteRating(movie.value.id);
                        },
                        child: MovieRatingItem(
                          key: UniqueKey(),
                          movie: movie.value,
                          trailing: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(Icons.star, color: Colors.amber),
                              const SizedBox(width: 5),
                              Text(
                                (movieInRatedMovies(
                                            state.ratedMovies, movie.value) /
                                        2)
                                    .toString(),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                          height: movie.key == rateList.length - 1 ? 45 : 15)
                    ],
                  ),
                ),
          ]);
    });
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

  List<Movie> sortedList(List<Movie> list, int order) {
    if (order == 0) {
      return list;
    } else if (order == 1) {
      var newList = list.toList()
        ..sort((b, a) => a.ownRating.compareTo(b.ownRating));
      return newList;
    } else if (order == 2) {
      var newList = list.toList()
        ..sort((a, b) => a.ownRating.compareTo(b.ownRating));
      return newList;
    }
    return list;
  }
}
