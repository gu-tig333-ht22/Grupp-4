// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:template/AddMovie.dart';
import 'package:template/models/movie.dart';
import 'package:provider/provider.dart';
import 'package:template/widgets/shimmer_loader.dart';
import 'package:template/MovieDetails.dart';

class WatchListSession extends StatefulWidget {
  const WatchListSession({super.key});

  @override
  State<WatchListSession> createState() => WatchListSessionState();
}

class WatchListSessionState extends State<WatchListSession> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.add, color: Colors.white, size: 30),
                tooltip: 'Add movie',
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AddMovie())),
              )
            ],
            backgroundColor: Color(0xFF27272D),
            centerTitle: true,
            title: const Text(
              'My Watchlist',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color.fromARGB(255, 255, 255, 255)),
            )),
        body: Consumer<MyState>(
          builder: ((context, state, child) => _watchList(state.watchList)),
        ));
  }

  Widget moviePoster(Movie movie, bool active) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Consumer<MyState>(
        builder: (context, state, child) => GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (con) => MovieDetails(movie.id)));
          },
          child: AnimatedContainer(
            width: 120,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOutCubic,
            margin: EdgeInsets.all(active ? 0 : 15),
            child: AnimatedOpacity(
              opacity: active ? 1.0 : 0.2,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutCubic,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: movie.poster == null
                    ? Image.asset("./assets/spiderman.jpg")
                    : Image.network(
                        'https://image.tmdb.org/t/p/w500/${movie.poster}',
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const SizedBox(child: ShimmerLoader());
                        },
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _watchList(watchlist) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: GridView.builder(
          itemCount: watchlist.length,
          itemBuilder: ((context, index) =>
              moviePoster(watchlist![index], true)),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3)),
    );
  }
}
