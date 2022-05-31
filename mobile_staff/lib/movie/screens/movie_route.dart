import 'package:flutter/material.dart';
import 'package:flutter_network/movie/movie.dart';

import '../models/movie.dart';

class MovieAppRoute {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => MoviesList());
    }

    if (settings.name == AddUpdateMovie.routeName) {
      MovieArgument args = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => AddUpdateMovie(
                args: args,
              ));
    }

    if (settings.name == MovieDetail.routeName) {
      Movie movie = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => MovieDetail(
                movie: movie,
              ));
    }

    return MaterialPageRoute(builder: (context) => MoviesList());
  }
}

class MovieArgument {
  final Movie movie;
  final bool edit;
  MovieArgument({this.movie, this.edit});
}
