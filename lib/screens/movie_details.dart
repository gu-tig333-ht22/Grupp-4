import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/models/movie.dart';
import 'package:template/providers/movie_provider.dart';
import 'package:template/screens/review_feed.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieDetails extends StatefulWidget {
  final int movieId;

  const MovieDetails({required this.movieId, super.key});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieState>(context, listen: false).getMovie(widget.movieId);
      Provider.of<MovieState>(context, listen: false).getCast(widget.movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieState>(
        builder: (context, state, child) => Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xFF27272D),
                title: Center(
                  child:
                      state.movie != null && state.movie!.id == widget.movieId
                          ? Text(state.movie!.title)
                          : const Text(""),
                ),
                actions: [
                  IconButton(
                    icon: movieIdInFavoriteList(widget.movieId, state)
                        ? const Icon(
                            Icons.favorite_outlined,
                            color: Colors.red,
                          )
                        : const Icon(
                            Icons.favorite_outline,
                            color: Colors.white,
                          ),
                    onPressed: () {
                      if (movieIdInFavoriteList(widget.movieId, state)) {
                        Provider.of<MovieState>(context, listen: false)
                            .deleteFavorites(widget.movieId);
                      } else {
                        Provider.of<MovieState>(context, listen: false)
                            .addFavorites(widget.movieId);
                      }
                    },
                  )
                ],
              ),
              body: Consumer<MovieState>(builder: (context, state, child) {
                if (state.movie != null && state.movie!.id == widget.movieId) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _imageRow(context, state, state.movie!),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _readReviews(state.movie!),
                            _addToWatchList(state.movie!, state),
                          ],
                        ),
                        _headLine("About"),
                        state.movie!.overview == ""
                            ? _textContainer(
                                'No information is available for this movie.')
                            : _textContainer(state.movie!.overview),
                        const SizedBox(height: 25),
                        _headLine("Cast"),
                        state.castList.isEmpty
                            ? _textContainer(
                                'No cast information is available for this movie.')
                            : _castRow()
                      ],
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
            ));
  }

  Widget _ratingBar(MovieState state, Movie movie) {
    return RatingBar.builder(
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
    );
  }

  Widget _imageRow(BuildContext context, MovieState state, Movie movie) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _image(movie.poster),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 40, bottom: 50, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.watch_later_outlined,
                        color: Colors.white,
                        size: 23.25,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(
                          movie.runTime == 0
                              ? '-'
                              : '${movie.runTime.toString()} min',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_border_outlined,
                        color: Colors.white,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(
                          movie.rating == 0
                              ? '-'
                              : movie.rating.toStringAsFixed(1),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const Icon(
                        Icons.category_outlined,
                        color: Colors.white,
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: movie.genres.isEmpty
                              ? const Text("-")
                              : Text(
                                  _genres(movie),
                                  style: const TextStyle(fontSize: 16),
                                  overflow: TextOverflow.ellipsis,
                                ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 30,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.date_range_outlined,
                        color: Colors.white,
                        size: 23.5,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(
                          movie.releaseDate != ""
                              ? movie.releaseDate.substring(0, 4)
                              : '-',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  Container(height: 20),
                  _ratingBar(state, state.movie!),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _image(String? poster) {
    return Expanded(
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          image: DecorationImage(
            image: poster != null
                ? NetworkImage('https://image.tmdb.org/t/p/w500/$poster')
                : const AssetImage('./assets/movie_default_poster.jpeg')
                    as ImageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _addToWatchList(Movie movie, MovieState state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 0.0, left: 10, bottom: 15),
        child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 29, 29, 33),
              elevation: 5,
            ),
            icon: (movieIdInWatchList(movie, state))
                ? const Icon(Icons.bookmark_outlined, color: Colors.white)
                : const Icon(Icons.bookmark_outline, color: Colors.white),
            onPressed: () {
              if (movieIdInWatchList(movie, state)) {
                (Provider.of<MovieState>(context, listen: false)
                    .removeFromWatchList(movie.id));
              } else {
                (Provider.of<MovieState>(context, listen: false)
                    .addToWatchList(movie.id));
              }
            },
            label: (movieIdInWatchList(movie, state))
                ? const Text("Delete from watchlist",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.normal))
                : const Text("Add to watchlist",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.normal))),
      ),
    );
  }

  Widget _readReviews(Movie movie) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 5,
              backgroundColor: const Color.fromARGB(255, 29, 29, 33)),
          onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (con) => ReviewFeed(movie: movie))),
          child: Row(
            children: const [
              Icon(Icons.reviews, color: Colors.white),
              SizedBox(width: 10),
              Text(
                "Read reviews",
                style: TextStyle(fontSize: 14),
              ),
            ],
          )),
    );
  }

  Widget _headLine(String text) {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      child: Text(
        text,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _textContainer(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
      child: Card(
        elevation: 20,
        color: const Color.fromARGB(255, 29, 29, 33),
        child: Container(
            margin:
                const EdgeInsets.only(left: 15, right: 10, top: 10, bottom: 10),
            child: Text(text)),
      ),
    );
  }

  Widget _castRow() {
    return Consumer<MovieState>(
      builder: (context, state, child) => Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, left: 10),
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: state.castList.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 20,
                  color: const Color.fromARGB(255, 29, 29, 33),
                  child: Column(
                    children: [
                      Container(
                        height: 130,
                        width: 85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: state.castList[index].poster != null
                                  ? NetworkImage(
                                      'https://image.tmdb.org/t/p/w200${state.castList[index].poster}')
                                  : const AssetImage('assets/placeholder.png')
                                      as ImageProvider),
                        ),
                      ),
                      Container(height: 10),
                      SizedBox(
                        height: 50,
                        width: 85,
                        child: Text(
                          state.castList[index].name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: 85,
                          child: Text(
                            state.castList[index].character,
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _genres(Movie movie) {
    List<dynamic> genreList = [];
    for (var genre in movie.genres) {
      genreList.add(genre['name']);
    }
    return genreList.join('\n');
  }

  bool movieIdInWatchList(Movie movie, MovieState state) {
    for (var i = 0; i < state.watchList.length; i++) {
      if (movie.id == state.watchList[i].id) {
        return true;
      }
    }
    return false;
  }

  bool movieIdInFavoriteList(int movie, MovieState state) {
    for (var i = 0; i < state.favorite.length; i++) {
      if (movie == state.favorite[i].id) {
        return true;
      }
    }
    return false;
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
}
