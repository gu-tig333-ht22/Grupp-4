import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:template/models/movie.dart';

const baseUrl = 'https://api.themoviedb.org/3';
const apiKey = 'api_key=f70ecb57844925f70e0596d29bc2b37a';
const movieEndpoint =
    '/movie/120?api_key=f70ecb57844925f70e0596d29bc2b37a&language=en-US';
const requestToken = 'fa955b6f6c47b4ad6365ae007b3b2f784309981c';
const requestToken2 = '1aa79b76b6f493b8b730250a321b5cfae0deb0ac';
const sessionId = 'fd7120cdae39265b9bcb1bbbb343193ef7aad181';
const accountId = '15074664';

class ApiCalls {
  static Future<Movie> fetchMovie(id) async {
    http.Response response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$id?api_key=f70ecb57844925f70e0596d29bc2b37a&language=en-US'));
    var jsonData = response.body;
    var obj = jsonDecode(jsonData);
    var newMovie = Movie.fromJson(obj);
    return newMovie;
  }

  static Future<List<Movie>> getHomeScreenMovies(String query) async {
    http.Response response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$query?api_key=f70ecb57844925f70e0596d29bc2b37a&language=en-US&page=1'));
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
        'https://api.themoviedb.org/3/search/movie?api_key=f70ecb57844925f70e0596d29bc2b37a&language=en-US&query=$search&page=1'));
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
    http.Response response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=f70ecb57844925f70e0596d29bc2b37a&language=en-US'));
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
        'https://api.themoviedb.org/3/account/15074664/favorite/movies?api_key=f70ecb57844925f70e0596d29bc2b37a&session_id=fd7120cdae39265b9bcb1bbbb343193ef7aad181&language=en-US&sort_by=created_at.asc&page=1'));
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
      Uri.parse(
          'https://api.themoviedb.org/3/account/15074664/favorite?api_key=f70ecb57844925f70e0596d29bc2b37a&session_id=fd7120cdae39265b9bcb1bbbb343193ef7aad181'),
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
      Uri.parse(
          'https://api.themoviedb.org/3/account/15074664/watchlist?api_key=f70ecb57844925f70e0596d29bc2b37a&session_id=fd7120cdae39265b9bcb1bbbb343193ef7aad181'),
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
        'https://api.themoviedb.org/3/account/15074664/watchlist/movies?api_key=f70ecb57844925f70e0596d29bc2b37a&language=en-US&session_id=fd7120cdae39265b9bcb1bbbb343193ef7aad181&sort_by=created_at.asc&page=1'));
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


  

/*
class ApiCalls {
  static Future<List<Movie>> fetchMovie() async {
    http.Response response = await http.get(Uri.parse(baseUrl + movieEndpoint));
    var jsonData = response.body;
    var obj = jsonDecode(jsonData);
    return obj.map<Movie>((data) {
      return Movie.fromJson(data);
    }).toList();
  }
}

*/