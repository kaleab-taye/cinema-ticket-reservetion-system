// import 'package:sec_2/movie/index.dart';

// class MovieLocalProvider implements MovieProvider {
//   final List<Movie> _movies = [
//     for (int i in List.generate(15, (i) => i))
//       Movie(description: "Movie number $i", priority: i % 6)
//   ];

//   @override
//   addMovie(Movie movie) async {
//     return _movies.add(movie);
//   }

//   @override
//   editMovie(int id, Movie movie) async {
//     int index = -1;
//     for (int i = 0; i < _movies.length; i++) {
//       if (_movies[i].id == id) {
//         index = i;
//         break;
//       }
//     }

//     if (index == -1) {
//       throw Exception("Movie not found");
//     }

//     _movies[index] = Movie(
//       description: movie.description,
//       priority: movie.priority,
//       id: id,
//     );
//   }

//   @override
//   Future<Movie> getMovie(int id) async {
//     for (int i = 0; i < _movies.length; i++) {
//       if (_movies[i].id == id) {
//         return _movies[i];
//       }
//     }

//     throw Exception('Movie not found');
//   }

//   @override
//   Future<List<Movie>> getAllMovies() async {
//     return _movies;
//   }
// }
