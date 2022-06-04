import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sec_2/movie/index.dart';

class MovieDetailScreen extends StatelessWidget {
  MovieDetailScreen({
    Key? key,
    required this.movie,
  }) : super(key: key) {
    // descCtrl.text = movie.description;
    // priorityCtrl.text = movie.priority.toString();
  }

  final Movie movie;
  // final descCtrl = TextEditingController();
  // final priorityCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.imageUrl!),
      ),
      body: Text(movie.imageUrl!),
      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         TextField(
      //           controller: descCtrl,
      //           decoration: InputDecoration(
      //             border: OutlineInputBorder(),
      //           ),
      //         ),
      //         SizedBox(height: 10),
      //         TextField(
      //           controller: priorityCtrl,
      //           decoration: InputDecoration(
      //             border: OutlineInputBorder(),
      //           ),
      //         ),
      //         SizedBox(height: 10),
      //         BlocListener<MovieBloc, MovieState>(
      //           listener: (_, MovieState state) {
      //             if (state is UpdateSuccessful) {
      //               Navigator.pop(context, true);
      //             }
      //           },
      //           child: ElevatedButton(
      //             onPressed: () {
      //               final movieBloc = BlocProvider.of<MovieBloc>(context);
      //               movieBloc.add(
      //                 UpdateMovie(
      //                   Movie(
      //                     id: movie.id,
      //                     description: descCtrl.text,
      //                     priority: int.parse(priorityCtrl.text),
      //                   ),
      //                 ),
      //               );
      //             },
      //             child: Text("Update"),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
