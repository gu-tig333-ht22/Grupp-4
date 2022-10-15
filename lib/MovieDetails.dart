import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/models/ApiCalls.dart';
import 'package:template/models/movie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieDetails extends StatefulWidget {
  final int movieId;

  MovieDetails(this.movieId);

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  void initState() {
    Provider.of<MyState>(context, listen: false).getMovie(widget.movieId);
    Provider.of<MyState>(context, listen: false).getCast(widget.movieId);
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
                    icon: const Icon(
                      Icons.favorite_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Provider.of<MyState>(context, listen: false)
                          .addFavorites();
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
                        _imageRow(state.movie),
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

  Widget _imageRow(movie) {
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
                  Row(
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
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const Icon(
                        Icons.category_outlined,
                        color: Colors.white,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(
                          movie!.genre[0]['name'].toString(),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.grey)),
                        icon: Icon(
                          Icons.bookmark_outlined,
                        ),
                        onPressed: () {},
                        label: const Text(
                          "Add to watchlist",
                          style: TextStyle(fontSize: 12),
                        )),
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
                ? NetworkImage('https://image.tmdb.org/t/p/w500/${poster}')
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
}
