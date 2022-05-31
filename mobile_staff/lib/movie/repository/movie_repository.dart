import 'package:meta/meta.dart';
import 'package:flutter_network/movie/movie.dart';
import '../models/movie.dart';

class MovieRepository {
  final MovieDataProvider dataProvider;

  MovieRepository({@required this.dataProvider}) : assert(dataProvider != null);

  Future<Movie> createMovie(Movie movie) async {
    return await dataProvider.createMovie(movie);
  }

  Future<List<Movie>> getMovies() async {
    //remove
    // print("movie repo lounched");
    // List<Movie> test = dataProvider.getMovies();
    // print(dataProvider.getMovies());
    //remove
    // return await dataProvider.getMovies();
    List<Movie> c = await dataProvider.getMovies();
    print(0);
    return c;
  }

  Future<void> updateMovie(Movie movie) async {
    await dataProvider.updateMovie(movie);
  }

  Future<void> deleteMovie(String id) async {
    await dataProvider.deleteMovie(id);
  }
}
