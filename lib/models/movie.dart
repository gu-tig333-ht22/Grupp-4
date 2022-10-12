import 'package:flutter/cupertino.dart';
import 'package:template/MovieDetails.dart';
import 'package:template/models/ApiCalls.dart';

class Movie {
  final String poster;
  final int id;
  final String title;
  final String overview;
  final double rating;

  const Movie(
      {required this.id,
      required this.poster,
      required this.title,
      required this.overview,
      required this.rating});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      poster: json['poster_path'],
      title: json['title'],
      overview: json['overview'],
      rating: json['vote_average'],
    );
  }
}

class MyState extends ChangeNotifier {
  List<Movie> _list = [];

  late Movie _movie;

  List<Movie> get list => _list;
  Movie get movie => _movie;

  void getMovie() async {
    var movie = await ApiCalls.fetchMovie(120);
    _movie = movie;
    notifyListeners();
  }
}
