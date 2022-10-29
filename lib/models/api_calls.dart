import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:template/models/cast.dart';
import 'package:template/models/movie.dart';
import 'package:template/models/review.dart';

const baseUrl = 'https://api.themoviedb.org/3';
const apiKey = 'api_key=f70ecb57844925f70e0596d29bc2b37a';
const sessionId = 'session_id=fd7120cdae39265b9bcb1bbbb343193ef7aad181';
const accountId = '15074664';

class ApiCalls {
  static Future<Movie> fetchMovie(id) async {
    http.Response response =
        await http.get(Uri.parse('$baseUrl/movie/$id?$apiKey&language=en-US'));
    var jsonData = response.body;
    var obj = jsonDecode(jsonData);
    var newMovie = Movie.fromJson(obj);
    return newMovie;
  }

  static Future<List<Movie>> getHomeScreenMovies(String query) async {
    http.Response response = await http
        .get(Uri.parse('$baseUrl/movie/$query?$apiKey&language=en-US&page=1'));
    if (response.statusCode == 200) {
      var jsonData = response.body;
      Map data = jsonDecode(jsonData);
      List<Movie> movies = data['results'].map<Movie>((movieData) {
        return Movie.fromJson(movieData);
      }).toList();
      return movies;
    } else {
      throw Exception('Couldnt get movies');
    }
  }

  static Future<List<Movie>> getSerachMovies(String search) async {
    http.Response response = await http.get(Uri.parse(
        '$baseUrl/search/movie?$apiKey&language=en-US&query=$search&page=1'));
    if (response.statusCode == 200) {
      var jsonData = response.body;
      Map data = jsonDecode(jsonData);
      List<Movie> movies = data['results'].map<Movie>((movieData) {
        return Movie.fromJson(movieData);
      }).toList();
      return movies;
    } else {
      throw Exception('Couldnt get movies');
    }
  }

  static Future<List<Cast>> getCast(movieId) async {
    http.Response response = await http.get(
        Uri.parse('$baseUrl/movie/$movieId/credits?$apiKey&language=en-US'));
    if (response.statusCode == 200) {
      var jsonData = response.body;
      Map data = jsonDecode(jsonData);
      List<Cast> cast = data['cast'].map<Cast>((castData) {
        return Cast.fromJson(castData);
      }).toList();
      return cast;
    } else {
      throw Exception('Could not get cast');
    }
  }

  static Future<List<Movie>> getFavorites() async {
    http.Response response = await http.get(Uri.parse(
        '$baseUrl/account/$accountId/favorite/movies?$apiKey&$sessionId&language=en-US&sort_by=created_at.asc&page=1'));
    if (response.statusCode == 200) {
      var jsonData = response.body;
      Map data = jsonDecode(jsonData);
      List<Movie> movies = data['results'].map<Movie>((movieData) {
        return Movie.fromJson(movieData);
      }).toList();
      return movies;
    } else {
      throw Exception('Couldnt get movies');
    }
  }

  static Future<http.Response> addFavorites(int id, bool favorite) {
    return http.post(
      Uri.parse('$baseUrl/account/$accountId/favorite?$apiKey&$sessionId'),
      headers: {'Content-Type': 'application/json;charset=utf-8'},
      body: jsonEncode(<String, dynamic>{
        'media_type': 'movie',
        'media_id': id,
        'favorite': favorite,
      }),
    );
  }

  static Future<http.Response> addToWatchList(int mediaID, bool watchlist) {
    return http.post(
      Uri.parse('$baseUrl/account/$accountId/watchlist?$apiKey&$sessionId'),
      headers: {'Content-Type': 'application/json;charset=utf-8'},
      body: jsonEncode(<String, dynamic>{
        'media_type': 'movie',
        'media_id': mediaID,
        'watchlist': watchlist,
      }),
    );
  }

  static Future<List<Movie>> getWatchList() async {
    http.Response response = await http.get(Uri.parse(
        '$baseUrl/account/$accountId/watchlist/movies?$apiKey&language=en-US&$sessionId&sort_by=created_at.asc&page=1'));
    if (response.statusCode == 200) {
      var jsonData = response.body;
      Map data = jsonDecode(jsonData);
      List<Movie> movies = data['results'].map<Movie>((movieData) {
        return Movie.fromJson(movieData);
      }).toList();
      return movies;
    } else {
      throw Exception('Couldnt get movies');
    }
  }

  static Future<List<Review>> getMovieReviews(int movieId) async {
    http.Response response = await http.get(Uri.parse(
        '$baseUrl/movie/$movieId/reviews?$apiKey&$sessionId&language=en-US&sort_by=created_at.asc&page=1'));
    if (response.statusCode == 200) {
      var jsonData = response.body;
      Map data = jsonDecode(jsonData);
      List<Review> reviews = data['results'].map<Review>((movieData) {
        return Review.fromJson(movieData);
      }).toList();
      return reviews;
    } else {
      throw Exception('Couldnt get movies');
    }
  }

  static Future<http.Response> postRating(int movieId, double value) {
    return http.post(
      Uri.parse('$baseUrl/movie/$movieId/rating?$apiKey&$sessionId'),
      headers: {'Content-Type': 'application/json;charset=utf-8'},
      body: jsonEncode(
        <String, dynamic>{
          "value": value,
        },
      ),
    );
  }

  static Future<http.Response> deleteRating(movieId) {
    return http.delete(
      Uri.parse('$baseUrl/movie/$movieId/rating?$apiKey&$sessionId'),
      headers: {'Content-Type': 'application/json;charset=utf-8'},
    );
  }

  static Future<List<Movie>> getRatedMovies() async {
    http.Response response = await http.get(Uri.parse(
        '$baseUrl/account/$accountId/rated/movies?$apiKey&language=en-US&$sessionId&sort_by=created_at.asc&page=1'));
    if (response.statusCode == 200) {
      var jsonData = response.body;
      Map data = jsonDecode(jsonData);
      List<Movie> movies = data['results'].map<Movie>((movieData) {
        return Movie.fromJson(movieData);
      }).toList();
      return movies;
    } else {
      throw Exception('Couldnt get movies');
    }
  }
}
