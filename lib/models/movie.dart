import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:template/MovieDetails.dart';
import 'package:template/models/ApiCalls.dart';

class Movie {
  final String poster;
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

  List<Movie> _popularMovies = [];
  List<Movie> _topRatedMovies = [];
  List<Movie> _upComingMovies = [];
  List<Movie> _nowPlayingMovies = [];
  bool _loadingHomeScreen = false;

  late Movie _movie;

  List<Movie> get movies => _movies;
  Movie get movie => _movie;
  List<Cast> get castList => _castList;
  List<Movie> get popularMovies => _popularMovies;
  List<Movie> get topRatedMovies => _topRatedMovies;
  List<Movie> get upComingMovies => _upComingMovies;
  List<Movie> get nowPlayingMovies => _nowPlayingMovies;
  bool get loadingHomeScreen => _loadingHomeScreen; 

  MyState() {
    //getPopularMovies();
    getCast();
    getHomePageState();
  }

  void getMovie() async {
    var movie = await ApiCalls.fetchMovie(120);
    _movie = movie;
    notifyListeners();
  }

  void getCast() async {
    var cast = await ApiCalls.getCast(120);
    _castList = cast;
    notifyListeners();
  }

  // void getPopularMovies() async {
  //   _movies = await ApiCalls.getPopularMovies();
  //   notifyListeners();
  // }

  void getHomePageState() async {
    _loadingHomeScreen = true;
    notifyListeners();
    await getPopularMovies();
    await getTopRatedMovies();
    await getUpComingMovies();
    await getNowPlayingMovies();
    _loadingHomeScreen = false;
    notifyListeners();
  }

  Future<void> getPopularMovies() async {
    _popularMovies = await ApiCalls.getPopularMovies();
  }

  Future<void> getTopRatedMovies() async {
    _topRatedMovies = await ApiCalls.getTopRatedMovies();
  }

  Future<void> getUpComingMovies() async {
    _upComingMovies = await ApiCalls.getUpcomingMovies();
  }

  Future<void> getNowPlayingMovies() async {
    _nowPlayingMovies = await ApiCalls.getNowPlayingMovies();
  }
}
