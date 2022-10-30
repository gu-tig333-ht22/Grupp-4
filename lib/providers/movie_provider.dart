import 'package:flutter/material.dart';
import 'package:template/models/api_calls.dart';
import 'package:template/models/cast.dart';
import 'package:template/models/movie.dart';

class MovieState extends ChangeNotifier {
  List<Cast> _castList = [];
  List<Movie> _favorite = [];
  List<Movie> _watchList = [];
  List<Movie> _ratedMovies = [];
  int _filterBy = 0;
  int _watchListFilterBy = 0;
  int _ratingFilterBy = 0;
  bool _deleteMovie = false;
  bool _shakeMovie = false;

  Movie? _movie;

  Movie? get movie => _movie;
  List<Cast> get castList => _castList;
  List<Movie> get favorite => _favorite;
  List<Movie> get watchList => _watchList;
  List<Movie> get ratedMovies => _ratedMovies;
  int get filterBy => _filterBy;
  int get watchListFilterBy => _watchListFilterBy;
  int get ratingFilterBy => _ratingFilterBy;
  bool get deleteMovie => _deleteMovie;
  bool get shakeMovie => _shakeMovie;

  MovieState() {
    getFavorites();
    getWatchList();
    getRatedMovies();
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

  void addFavorites(int movieId) async {
    await ApiCalls.addFavorites(movieId, true);
    getFavorites();
    notifyListeners();
  }

  void deleteFavorites(int movieId) async {
    await ApiCalls.addFavorites(movieId, false);
    getFavorites();
    notifyListeners();
  }

  void getWatchList() async {
    var watchList = await ApiCalls.getWatchList();
    _watchList = watchList;
    notifyListeners();
  }

  void addToWatchList(int movieId) async {
    await ApiCalls.addToWatchList(movieId, true);
    getWatchList();
    notifyListeners();
  }

  void removeFromWatchList(int movieId) async {
    await ApiCalls.addToWatchList(movieId, false);
    getWatchList();
    notifyListeners();
  }

  void getRatedMovies() async {
    var ratedMovies = await ApiCalls.getRatedMovies();
    _ratedMovies = ratedMovies;
    notifyListeners();
  }

  void postRating(int movieId, double value) async {
    await ApiCalls.postRating(movieId, value);
    getRatedMovies();
    notifyListeners();
  }

  void deleteRating(int movieId) async {
    await ApiCalls.deleteRating(movieId);
    _ratedMovies.removeWhere((movie) => movie.id == movieId);
    notifyListeners();
  }

  void setFilterBy(int filterBy) {
    _filterBy = filterBy;
    notifyListeners();
  }

  void setWatchListFilterBy(int watchListFilterBy) {
    _watchListFilterBy = watchListFilterBy;
    notifyListeners();
  }

  void setratingFilterBy(int ratingFilterBy) {
    _ratingFilterBy = ratingFilterBy;
    notifyListeners();
  }

  void setDeleteMovie() {
    _deleteMovie = !_deleteMovie;
    notifyListeners();
  }

  void setDeleteMovieFalse() {
    _deleteMovie = false;
    notifyListeners();
  }

  void setShakeTrue() {
    _shakeMovie = true;
    notifyListeners();
  }

  void setShakeFalse() {
    _shakeMovie = false;
    notifyListeners();
  }
}
