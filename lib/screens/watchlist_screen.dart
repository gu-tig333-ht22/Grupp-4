import 'dart:async';
import 'package:flutter/material.dart';
import 'package:template/models/movie.dart';
import 'package:template/providers/movie_provider.dart';
import 'package:template/screens/add_movie.dart';
import 'package:provider/provider.dart';
import 'package:template/widgets/menu_button.dart';
import 'package:template/widgets/movie_poster.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({super.key});

  @override
  State<WatchListScreen> createState() => WatchListScreenState();
}

class WatchListScreenState extends State<WatchListScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: GestureDetector(onTap: () async {
          await _animationController.reverse();
          Provider.of<MovieState>(context, listen: false).setDeleteMovieFalse();
        }),
        leading: IconButton(
            icon: const Icon(Icons.add, color: Colors.white, size: 30),
            tooltip: 'Add movie',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const AddMovie(),
                ),
              );
              _animationController.reverse();
              Provider.of<MovieState>(context, listen: false)
                  .setDeleteMovieFalse();
            }),
        actions: [
          Consumer<MovieState>(
            builder: (context, state, child) => Center(
              child: Text(
                GenreListMap.genreMap[state.watchListFilterBy],
              ),
            ),
          ),
          MenuButton(
            onSelectedFunctionCallback: (value) => {
              Provider.of<MovieState>(context, listen: false)
                  .setWatchListFilterBy(value)
            },
          ),
        ],
        backgroundColor: const Color(0xFF27272D),
        centerTitle: true,
        title: const Text(
          'My Watchlist',
        ),
      ),
      body: Consumer<MovieState>(
        builder: ((context, state, child) {
          if (state.watchList.isEmpty) {
            return const Center(
                child: Text("You have no movies in your watchlist yet."));
          }
          if (FilterList.filterList(state.watchList, state.watchListFilterBy)
              .isEmpty) {
            return const Center(
              child: Text(
                  "You have no movies of this genre in your watchlist yet."),
            );
          } else {
            return _watchList(
                FilterList.filterList(state.watchList, state.watchListFilterBy),
                state);
          }
        }),
      ),
    );
  }

  Widget _watchList(List<Movie> watchlist, state) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        await _animationController.reverse();
        Provider.of<MovieState>(context, listen: false).setDeleteMovieFalse();
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: GridView.builder(
          itemCount: watchlist.length,
          itemBuilder: ((context, index) => GestureDetector(
                onLongPressStart: (details) {
                  Provider.of<MovieState>(context, listen: false)
                      .setShakeTrue();
                },
                onLongPress: () {
                  Timer(const Duration(milliseconds: 400), () {
                    _animationController.forward();
                    Provider.of<MovieState>(context, listen: false)
                        .setDeleteMovie();
                    Provider.of<MovieState>(context, listen: false)
                        .setShakeFalse();
                  });
                },
                child: state.deleteMovie
                    ? Stack(fit: StackFit.expand, children: [
                        MoviePoster(
                            movie: watchlist[index],
                            active: true,
                            animationController: _animationController),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 2, 2),
                            child: IconButton(
                              onPressed: () {
                                Provider.of<MovieState>(context, listen: false)
                                    .removeFromWatchList(watchlist[index].id);
                              },
                              icon: AnimatedIcon(
                                  icon: AnimatedIcons.menu_close,
                                  progress: _animationController),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ])
                    : state.shakeMovie
                        ? ShakeWidget(
                            shakeConstant: ShakeDefaultConstant1(),
                            autoPlay: true,
                            child: MoviePoster(
                                movie: watchlist[index], active: true))
                        : MoviePoster(
                            movie: watchlist[index],
                            active: true,
                            animationController: _animationController),
              )),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1 / 1.4, crossAxisCount: 3),
        ),
      ),
    );
  }

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
  }

  /* @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }*/
}
