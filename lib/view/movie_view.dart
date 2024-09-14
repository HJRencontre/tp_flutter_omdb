import 'package:flutter/material.dart';

import '../data/movie_list.dart';
import '../model/movie.dart';
import '../service/api_service.dart';
import 'movie_list_view.dart';

class MovieView extends StatefulWidget {
  const MovieView({super.key, required this.title});

  final String title;

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  late final ApiKeyService _apiKeyService;
  late Future<List<Movie>> _movies;
  final Set<String> _favoriteMovies = {};

  @override
  void initState() {
    super.initState();
    _apiKeyService = ApiKeyService();
    _movies = fetchMovies();
  }

  Future<List<Movie>> fetchMovies() async {
    List<Movie> movies = [];
    for (var movie in movieList) {
      movies.add(await _apiKeyService.fetchMovie(movie.id));
    }
    return movies;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: _movies,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No movies found');
        } else {
          return MoviesListView(
            title: 'Movies',
            movies: snapshot.data!,
            favoriteMovies: _favoriteMovies,
          );
        }
      },
    );
  }
}
