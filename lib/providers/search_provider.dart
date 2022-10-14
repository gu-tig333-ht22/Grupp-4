import 'package:flutter/material.dart';
import 'package:template/models/ApiCalls.dart';
import 'package:template/models/movie.dart';

class SearchStateProvider extends ChangeNotifier {

  bool _isSearching = false;
  List<Movie>? _serachHits;

  bool get isSearching => _isSearching;
  List<Movie>? get serachHits => _serachHits;

  SearchStateProvider();

  Future<void> getSearchResult(String search) async {
    _isSearching = true;
    notifyListeners();
    _serachHits = await ApiCalls.getSerachMovies(search);
    _isSearching = false;
    notifyListeners();
  }

  disposeSerach() {
    _serachHits = null;
    notifyListeners();
  }

}