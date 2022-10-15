import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:template/MovieDetails.dart';
import 'package:template/models/ApiCalls.dart';

class Movie {
  final String? poster;
  final int id;
  final String title;
  final String overview;
  final num rating;
  final runTime;
  final genre;

  const Movie(
      {required this.id,
      required this.poster,
      required this.title,
      required this.overview,
      required this.rating,
      required this.runTime,
      required this.genre});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? "",
      poster: json['poster_path'],
      title: json['title'],
      overview: json['overview'],
      rating: json['vote_average'] ?? "",
      runTime: json['runtime'] ?? "",
      genre: json['genres'],
    );
  }
}

class Cast {
  final String name;
  var poster;
  final String character;

  Cast({required this.name, required this.poster, required this.character});

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
        name: json['name'],
        poster: json['profile_path'],
        character: json['character']);
  }
}

class MyState extends ChangeNotifier {
  List<Movie> _movies = [];
  List<Cast> _castList = [];
  List<Movie> _favorite = [];

  Movie? _movie;

  List<Movie> get movies => _movies;
  Movie? get movie => _movie;
  List<Cast> get castList => _castList;
  List<Movie> get favorite => _favorite;

  MyState() {
    //getPopularMovies();
    getFavorites();
  }

  void getMovie(int id) async {
    var movie = await ApiCalls.fetchMovie(id);
    _movie = movie;
    notifyListeners();
  }

  void getCast(int movieId) async {
    var cast = await ApiCalls.getCast(movieId);
    _castList = cast;
    notifyListeners();
  }

  void getFavorites() async {
    var favorite = await ApiCalls.getFavorites();
    _favorite = favorite;
    notifyListeners();
  }

  void addFavorites() async {
    await ApiCalls.addFavorites(true);
    getFavorites();
    notifyListeners();
  }

  void deleteFavorites() async {
    http.Response response = await ApiCalls.addFavorites(false);
    getFavorites();
    notifyListeners();
    print(response.body);
  }

  // void getPopularMovies() async {
  //   _movies = await ApiCalls.getPopularMovies();
  //   notifyListeners();
  // }
}
