import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_network/movie/movie.dart';

import '../models/movie.dart';

class MovieDetail extends StatelessWidget {
  static const routeName = 'movieDetail';
  final Movie movie;

  MovieDetail({@required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${this.movie.title}'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.of(context).pushNamed(
              AddUpdateMovie.routeName,
              arguments: MovieArgument(movie: this.movie, edit: true),
            ),
          ),
          SizedBox(
            width: 32,
          ),
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                context.read<MovieBloc>().add(MovieDelete(this.movie));
                Navigator.of(context).pushNamedAndRemoveUntil(
                    MoviesList.routeName, (route) => false);
              }),
        ],
      ),
      body: Card(
        child: Column(
          children: [
            ListTile(
              title: Text('Title: ${this.movie.title}'),
              subtitle: Text('casts: ${this.movie.casts}'),
            ),
            Text(
              'Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(this.movie.description),
          ],
        ),
      ),
    );
  }
}
