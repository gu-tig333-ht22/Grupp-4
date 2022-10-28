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

  void addFavorites(id) async {
    await ApiCalls.addFavorites(id, true);
    getFavorites();
    notifyListeners();
  }

  void deleteFavorites(id) async {
    await ApiCalls.addFavorites(id, false);
    getFavorites();
    notifyListeners();
  }

  void getWatchList() async {
    var watchList = await ApiCalls.getWatchList();
    _watchList = watchList;
    notifyListeners();
  }

  void addToWatchList(mediaID) async {
    await ApiCalls.addToWatchList(mediaID, true);
    getWatchList();
    notifyListeners();
  }

  void removeFromWatchList(mediaID) async {
    await ApiCalls.addToWatchList(mediaID, false);
    getWatchList();
    notifyListeners();
  }

  void getRatedMovies() async {
    var ratedMovies = await ApiCalls.getRatedMovies();
    _ratedMovies = ratedMovies;
    notifyListeners();
  }

  void postRating(mediaID, value) async {
    await ApiCalls.postRating(mediaID, value);
    getRatedMovies();
    notifyListeners();
  }

  void deleteRating(mediaID) async {
    await ApiCalls.deleteRating(mediaID);
    getRatedMovies();
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
}
