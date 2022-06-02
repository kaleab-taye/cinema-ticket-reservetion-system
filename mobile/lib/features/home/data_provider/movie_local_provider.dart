

import 'movie_provider.dart';
import '../model/movie.dart';

class MovieLocalProvider implements MovieProvider {
  final List<Movie> movies = [
    for (int i in List.generate(15, (i) => i))
      Movie(title: "Bad Boys", description: "What r u", imageUrl: "imageUrl", casts: [], genera: [])
  ];

  @override
  addMovie(Movie movie) async {
    return movies.add(movie);
  }

  @override
  editMovie(String id, Movie movie) async {
    int index = -1;
    for (int i = 0; i < movies.length; i++) {
      if (movies[i].id == id) {
        index = i;
        break;
      }
    }

    if (index == -1) {
      throw Exception("Movie not found");
    }

    movies[index] = Movie(title: movie.title,
        description: movie.description,
        imageUrl: movie.imageUrl,
        casts: movie.casts,
        genera: movie.genera);
  }

  @override
  Future<Movie> getMovie(String id) async {
    for (int i = 0; i < movies.length; i++) {
      if (movies[i].id == id) {
        return movies[i];
      }
    }

    throw Exception('Movie not found');
  }

  @override
  Future<List<Movie>> getAllMovies() async {
    return movies;
  }
}
