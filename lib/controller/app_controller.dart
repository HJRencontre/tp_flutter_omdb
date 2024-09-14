import 'package:flutter/material.dart';
import 'package:flutter_imdb/view/favorite_movie_view.dart';
import 'package:flutter_imdb/view/movie_view.dart';

import '../model/movie.dart';
import '../view/about_view.dart';
import '../view/navigation/drawer_view.dart';
import '../view/navigation/menu_item.dart';

class AppController extends StatefulWidget {
  const AppController({super.key, required this.title});

  final String title;
  @override
  State<AppController> createState() => _AppControllerState();
}

class _AppControllerState extends State<AppController> {
  Widget body;
  final Set<Movie> _favoritesMovies = {};

  _AppControllerState() : body = const MovieView(title: 'Movies');

  void changeView(Widget newView) {
    setState(() {
      body = newView;
    });
  }

  late List<MenuItem> _menuItems;

  @override
  void initState() {
    super.initState();
    _menuItems = <MenuItem>[
      MenuItem(
        name: 'Movies',
        view: const MovieView(title: 'Movies'),
      ),
      MenuItem(
        name: 'Favorites',
        view: FavoriteMovieView(
            title: 'Favorites', favoriteMovies: _favoritesMovies.toList()),
      ),
      MenuItem(name: 'About', view: const AboutView()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: DrawerView(items: _menuItems, changeView: changeView),
      body: body,
    );
  }
}
