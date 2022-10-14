import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:template/models/movie.dart';

const baseUrl = 'https://api.themoviedb.org/3';
const apiKey = 'api_key=f70ecb57844925f70e0596d29bc2b37a';
const movieEndpoint =
    '/movie/120?api_key=f70ecb57844925f70e0596d29bc2b37a&language=en-US';

class ApiCalls {
  static Future<Movie> fetchMovie(id) async {
    http.Response response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$id?api_key=f70ecb57844925f70e0596d29bc2b37a&language=en-US'));
    var jsonData = response.body;
    var obj = jsonDecode(jsonData);
    var newMovie = Movie.fromJson(obj);
    print(newMovie);
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