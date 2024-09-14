import 'package:flutter/material.dart';

import '../model/movie.dart';

class MovieDetailBottomSheet extends StatelessWidget {
  final Movie movie;

  const MovieDetailBottomSheet({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          movie.image != null
              ? Image.network(movie.image!, height: 300)
              : const Icon(Icons.movie, size: 100),
          const SizedBox(height: 16),
          Text(movie.title ?? 'No title',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text('Date: ${movie.releaseDate}'),
          const SizedBox(height: 8),
          Text('Duration: ${movie.duration}'),
        ],
      ),
    );
  }
}
