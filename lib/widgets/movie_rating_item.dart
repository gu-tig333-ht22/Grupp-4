import 'package:flutter/material.dart';
import 'package:template/models/movie.dart';
import 'package:template/screens/movie_details.dart';
import 'package:template/widgets/movie_poster.dart';

class MovieRatingItem extends StatelessWidget {
  final Movie movie;
  final Widget trailing;
  const MovieRatingItem({required this.movie, required this.trailing, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (con) => MovieDetails(movieId: movie.id))),
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(5, 5),
                  blurRadius: 15,
                  spreadRadius: 5)
            ],
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xFF27272D),
          ),
          child: Row(
            children: [
              SizedBox(
                  height: 90,
                  child: MoviePoster(
                    movie: movie,
                    active: true,
                    width: 60,
                    padding: 5,
                  )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                              Text(movie.title),
                              const Spacer(),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: trailing)
                        ],
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
