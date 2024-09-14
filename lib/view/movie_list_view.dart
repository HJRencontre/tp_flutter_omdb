import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/movie.dart';
import 'movie_detail_view.dart';

class MoviesListView extends StatefulWidget {
  final String title;
  final List<Movie> movies;
  final Set<String> favoriteMovies;

  const MoviesListView({
    super.key,
    required this.title,
    required this.movies,
    required this.favoriteMovies,
  });

  @override
  State<MoviesListView> createState() => _MoviesListViewState();
}

class _MoviesListViewState extends State<MoviesListView> {
  Future<void> onToggleFavorite(Movie movie) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteMovies =
        prefs.getStringList('favoriteMovies')?.toSet() ?? <String>{};

    setState(() {
      if (favoriteMovies.contains(movie.id)) {
        favoriteMovies.remove(movie.id);
      } else {
        favoriteMovies.add(movie.id);
      }
    });

    await prefs
        .setStringList('favoriteMovies', favoriteMovies.toList())
        .then((value) => print('Favorite movies updated: $favoriteMovies'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: widget.movies.isEmpty
          ? const Center(child: Text('No movies found'))
          : ListView.builder(
              itemCount: widget.movies.length,
              itemBuilder: (context, index) {
                final movie = widget.movies[index];
                final isFavorite = widget.favoriteMovies.contains(movie.id);
                return ListTile(
                  leading: movie.image != null
                      ? Image.network(movie.image!)
                      : const Icon(Icons.movie),
                  title: Text(movie.title ?? 'No title'),
                  subtitle: Text(
                      'Date: ${movie.releaseDate} - Duration: ${movie.duration}'),
                  trailing: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.star : Icons.star_border,
                      color: isFavorite ? Colors.yellow : null,
                    ),
                    onPressed: () {
                      onToggleFavorite(movie);
                    },
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) =>
                          MovieDetailBottomSheet(movie: movie),
                    );
                  },
                );
              },
            ),
    );
  }
}
