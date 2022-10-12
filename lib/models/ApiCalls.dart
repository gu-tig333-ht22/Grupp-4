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
    return newMovie;
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