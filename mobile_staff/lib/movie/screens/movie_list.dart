import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_network/movie/bloc/bloc.dart';
import 'package:flutter_network/movie/movie.dart';

class MoviesList extends StatelessWidget {
  static const routeName = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Movies'),
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (_, state) {
          if (state is MovieOperationFailure) {
            return Text('movie managing operation failed');
          }

          if (state is MoviesLoadSuccess) {
            final movies = state.movies;

            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (_, idx) => ListTile(
                title: Text('${movies[idx].title}'),
                subtitle: Text('${movies[idx].imageUrl}'),
                onTap: () => Navigator.of(context)
                    .pushNamed(MovieDetail.routeName, arguments: movies[idx]),
              ),
            );
          }

          return CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(
          AddUpdateMovie.routeName,
          arguments: MovieArgument(edit: false),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
