import 'package:flutter/material.dart';
import 'package:flutter_imdb/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/movie.dart';
import 'movie_list_view.dart';

class FavoriteMovieView extends StatefulWidget {
  const FavoriteMovieView(
      {super.key, required this.title, required this.favoriteMovies});

  final String title;
  final List<Movie> favoriteMovies;

  @override
  State<FavoriteMovieView> createState() => _FavoriteMovieState();
}

class _FavoriteMovieState extends State<FavoriteMovieView> {
  late final ApiKeyService _apiKeyService;
  late Future<List<Movie>> _favoriteMovies;

  @override
  void initState() {
    super.initState();
    _apiKeyService = ApiKeyService();
    _favoriteMovies = fetchFavoriteMovies();
  }

  Future<List<Movie>> fetchFavoriteMovies() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteMovieIds = prefs.getStringList('favoriteMovies') ?? [];
    final List<Movie> movies = [];
    for (var movieId in favoriteMovieIds) {
      final movie = await _apiKeyService.fetchMovie(movieId);
      movies.add(movie);
    }
    return movies;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: _favoriteMovies,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No favorite movies found');
        } else {
          return MoviesListView(
              title: 'Favorite movies',
              movies: snapshot.data!,
              favoriteMovies:
                  widget.favoriteMovies.map((movie) => movie.id).toSet());
        }
      },
    );
  }
}
