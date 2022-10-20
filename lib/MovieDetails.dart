import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/models/movie.dart';
import 'package:template/screens/raings_feed.dart';

class MovieDetails extends StatefulWidget {
  final int movieId;

  MovieDetails(this.movieId);

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  void initState() {
    super.initState();
    Provider.of<MyState>(context, listen: false).getMovie(widget.movieId);
    Provider.of<MyState>(context, listen: false).getCast(widget.movieId);
    Provider.of<MyState>(context, listen: false).getWatchList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyState>(
        builder: (context, state, child) => Scaffold(
              appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 29, 29, 33),
                title: Center(
                  child:
                      state.movie != null && state.movie!.id == widget.movieId
                          ? Text(state.movie!.title)
                          : Text(""),
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
                        Provider.of<MyState>(context, listen: false)
                            .deleteFavorites(widget.movieId);
                      } else {
                        Provider.of<MyState>(context, listen: false)
                            .addFavorites(widget.movieId);
                      }
                    },
                  )
                ],
              ),
              body: Consumer<MyState>(builder: (context, state, child) {
                if (state.movie != null && state.movie!.id == widget.movieId) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _imageRow(context, state, state.movie),
                        _headLine("About"),
                        _textContainer(state.movie!.overview),
                        _headLine("Cast"),
                        _castRow(),
                      ],
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
            ));
  }

  Widget _imageRow(context, state, movie) {
    List movieidlist =
        [].asMap().entries.map((e) => '${e.key}:${e.value}').toList();
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, bottom: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
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
                        size: 18,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(
                          '${movie.runTime.toString()} min',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (con) => ReviewFeed(movie: movie))),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.star_border_outlined,
                          color: Colors.white,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            movie!.rating.toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const Icon(
                        Icons.category_outlined,
                        color: Colors.white,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: movie!.genres.isEmpty
                            ? Text("")
                            : Text(
                                _genres(movie),
                                style: const TextStyle(fontSize: 16),
                              ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: TextButton.icon(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                            alignment: Alignment.centerLeft),
                        icon: (movieIdInWatchList(movie, state))
                            ? Icon(Icons.bookmark_outlined, color: Colors.white)
                            : Icon(Icons.bookmark_outline, color: Colors.white),
                        onPressed: () {
                          if (movieIdInWatchList(movie, state)) {
                            (Provider.of<MyState>(context, listen: false)
                                .removeFromWatchList(movie!.id));
                          } else {
                            (Provider.of<MyState>(context, listen: false)
                                .addToWatchList(movie!.id));
                          }
                        },
                        label: (movieIdInWatchList(movie, state))
                            ? Text("Delete from watchlist",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white))
                            : const Text("Add to watchlist",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white))),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _image(poster) {
    return Expanded(
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          image: DecorationImage(
            image: poster != null
                ? NetworkImage('https://image.tmdb.org/t/p/w500/$poster')
                : Image.asset('./assets/temp_movie_poster/movieDefualt.jpeg')
                    as ImageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
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

  Widget _textContainer(text) {
    return Container(
        margin: const EdgeInsets.only(left: 15, right: 10, top: 10, bottom: 20),
        child: Text(text));
  }

  Widget _castRow() {
    return Consumer<MyState>(
      builder: (context, state, child) => Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, left: 10),
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: state.castList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      height: 130,
                      width: 85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        image: DecorationImage(
                            image: state.castList[index].poster != null
                                ? NetworkImage(
                                    'https://image.tmdb.org/t/p/w200${state.castList[index].poster}')
                                : const AssetImage('assets/placeholder.png')
                                    as ImageProvider),
                      ),
                    ),
                    Container(height: 10),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      height: 50,
                      width: 85,
                      child: Text(
                        state.castList[index].name,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 10, top: 10),
                        width: 85,
                        child: Text(
                          state.castList[index].character,
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                        )),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _genres(movie) {
    List<dynamic> genreList = [];
    for (var genre in movie!.genres) {
      genreList.add(genre['name']);
    }
    var genreListMapped = genreList.map;
    return genreList.join('\n');
  }

  bool movieIdInWatchList(movie, state) {
    for (var i = 0; i < state.watchList.length; i++) {
      if (movie.id == state.watchList[i].id) {
        return true;
      }
    }
    return false;
  }

  bool movieIdInFavoriteList(movie, state) {
    for (var i = 0; i < state.favorite.length; i++) {
      if (movie == state.favorite[i].id) {
        return true;
      }
    }
    return false;
  }
}
