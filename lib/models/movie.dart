class Movie {
  final String? poster;
  final int id;
  final String title;
  final String overview;
  final num rating;
  final int runTime;
  final List<dynamic> genres;
  final List<dynamic> genreId;
  final double ownRating;
  final String releaseDate;

  const Movie(
      {required this.id,
      required this.poster,
      required this.title,
      required this.overview,
      required this.rating,
      required this.runTime,
      required this.genres,
      required this.genreId,
      required this.ownRating,
      required this.releaseDate});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? "",
      poster: json['poster_path'],
      title: json['title'],
      overview: json['overview'],
      rating: json['vote_average'] ?? "",
      runTime: json['runtime'] ?? 0,
      genres: json['genres'] ?? [1],
      genreId: json['genre_ids'] ?? [1],
      ownRating: json['rating'] ?? 5,
      releaseDate: json['release_date'] ?? "",
    );
  }
}

class FilterList {
  static List<Movie> filterList(list, value) {
    if (value == 0) return list;

    List<Movie> returnMovies = [];

    for (Movie movie in list) {
      if (movie.genreId.contains(value)) returnMovies.add(movie);
    }

    return returnMovies;
  }
}
