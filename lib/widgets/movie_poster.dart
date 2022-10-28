import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/models/movie.dart';
import 'package:template/providers/movie_provider.dart';
import 'package:template/screens/movie_details.dart';
import 'package:template/widgets/shimmer_loader.dart';

class MoviePoster extends StatelessWidget {
  final Movie movie;
  final bool active;
  final double width;
  final double padding;
  const MoviePoster(
      {required this.movie,
      required this.active,
      this.width = 120,
      this.padding = 10,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Consumer<MovieState>(builder: (context, state, child) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (con) => MovieDetails(movieId: movie.id)));
          },
          child: AnimatedContainer(
            width: width,
            duration: const Duration(milliseconds: 500),
            padding: EdgeInsets.all(active ? 0 : 15),
            curve: Curves.easeInOutCubic,
            child: AnimatedOpacity(
              opacity: active ? 1.0 : 0.2,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutCubic,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(active ? 15 : 25),
                child: movie.poster == null
                    ? Image.asset("./assets/movie_default_poster.jpeg")
                    : Image.network(
                        'https://image.tmdb.org/t/p/w500/${movie.poster}',
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const SizedBox(child: ShimmerLoader());
                        },
                      ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
