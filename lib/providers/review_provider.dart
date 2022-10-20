import 'package:flutter/material.dart';
import 'package:template/models/ApiCalls.dart';
import 'package:template/models/review.dart';

class ReviewProvider extends ChangeNotifier {

  List<Review>? _reviews;

  ReviewProvider();

  List<Review>? get reviews => _reviews;

  void getReviews(int movieId) async {
    _reviews = await ApiCalls.getMovieReviews(movieId);
    notifyListeners();
  }

}