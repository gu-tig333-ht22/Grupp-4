import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/models/movie.dart';
import 'package:template/providers/movie_provider.dart';
import 'package:template/widgets/movie_poster.dart';

class MovieFavoriteItem extends StatelessWidget {
  final Movie movie;
  const MovieFavoriteItem({required this.movie, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MoviePoster(movie: movie, active: true),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 2, 2),
            child: GestureDetector(
              onTap: () => Provider.of<MovieState>(context, listen: false)
                  .deleteFavorites(movie.id),
              child: Icon(
                Icons.favorite,
                color: Colors.red,
                size: 30,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(1, 1),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
