import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_network/bloc_observer.dart';
import 'package:flutter_network/movie/movie.dart';
import 'package:http/http.dart' as http;

void main() {
  Bloc.observer = SimpleBlocObserver();

  final MovieRepository movieRepository = MovieRepository(
    dataProvider: MovieDataProvider(
      httpClient: http.Client(),
    ),
  );

  runApp(
    MovieApp(movieRepository: movieRepository),
  );
}

class MovieApp extends StatelessWidget {
  final MovieRepository movieRepository;

  MovieApp({@required this.movieRepository}) : assert(movieRepository != null);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: this.movieRepository,
      child: BlocProvider(
        create: (context) =>
            MovieBloc(movieRepository: this.movieRepository)..add(MovieLoad()),
        child: MaterialApp(
          title: 'Movie App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          onGenerateRoute: MovieAppRoute.generateRoute,
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {}
}
