import 'package:flutter/material.dart';
import 'package:template/models/api_calls.dart';
import 'package:template/models/review.dart';

class ReviewProvider extends ChangeNotifier {

  List<Review>? _reviews;

  List<Review>? get reviews => _reviews;

  void getReviews(int movieId) async {
    _reviews = await ApiCalls.getMovieReviews(movieId);
    notifyListeners();
  }

  void clearReviews() {
    _reviews = null;
  }

}