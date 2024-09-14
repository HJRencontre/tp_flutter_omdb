import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/movie.dart';

class ApiKeyService {
  final String _apiKey = '7e65539';

  String getApiKey() {
    return _apiKey;
  }

  String getUrl(String movieId) {
    return 'http://www.omdbapi.com/?i=$movieId&apikey=$_apiKey';
  }

  Future<Movie> fetchMovie(String movieId) async {
    final response = await http.get(Uri.parse(getUrl(movieId)));

    if (response.statusCode == 200) {
      return Movie.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load movie');
    }
  }
}
