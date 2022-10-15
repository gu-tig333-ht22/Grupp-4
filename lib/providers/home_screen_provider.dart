import 'package:flutter/material.dart';
import 'package:template/models/ApiCalls.dart';
import 'package:template/models/movie.dart';

class HomeScreenStateProvider extends ChangeNotifier {
  List<Movie> _popularMovies = [];
  List<Movie> _topRatedMovies = [];
  List<Movie> _upComingMovies = [];
  List<Movie> _nowPlayingMovies = [];
  bool _loadingHomeScreen = false;

  List<Movie> get popularMovies => _popularMovies;
  List<Movie> get topRatedMovies => _topRatedMovies;
  List<Movie> get upComingMovies => _upComingMovies;
  List<Movie> get nowPlayingMovies => _nowPlayingMovies;
  bool get loadingHomeScreen => _loadingHomeScreen;

  HomeScreenStateProvider() {
    getHomePageState();
  }

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
    _popularMovies = await ApiCalls.getHomeScreenMovies("popular");
  }

  Future<void> getTopRatedMovies() async {
    _topRatedMovies = await ApiCalls.getHomeScreenMovies("top_rated");
  }

  Future<void> getUpComingMovies() async {
    _upComingMovies = await ApiCalls.getHomeScreenMovies("upcoming");
  }

  Future<void> getNowPlayingMovies() async {
    _nowPlayingMovies = await ApiCalls.getHomeScreenMovies("now_playing");
  }
}
