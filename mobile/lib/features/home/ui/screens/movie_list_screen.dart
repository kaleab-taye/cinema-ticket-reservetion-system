// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:royal_cinema/core/api_data.dart';
import 'package:royal_cinema/features/home/bloc/movie_bloc.dart';
import 'package:royal_cinema/features/home/bloc/movie_event.dart';
import 'package:royal_cinema/features/home/bloc/movie_state.dart';
import 'package:royal_cinema/features/home/ui/screens/movie_details_screen.dart';

import '../../../../core/utils/colors.dart';
import '../../model/movie.dart';
import '../widget/search_widget.dart';
import 'movie_view_edit_screen.dart';

class MovieListScreen extends StatelessWidget {
  MovieListScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      buildWhen: (p, c) => c is! UpdateSuccessful,
      builder: (_, MovieState state) {
        if (state is MoviesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is MoviesLoadingFailed) {
          return Center(
            child: Text(state.msg),
          );
        }

        if (state is MoviesLoaded) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSearch(),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text(
                    "Today's",
                    style: TextStyle(
                        color: Col.textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  decoration: BoxDecoration(color: Col.secondary),
                  child: ListView.builder(
                      itemCount: state.movies.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                          // final result = await Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (_) => MovieDetailsScreen(
                          //       movie: state.movies[index],
                          //     ),
                          //   ),
                          // );
                          //
                          // if (result == null) return;
                          //
                          // final movieBloc = BlocProvider.of<MovieBloc>(context);
                          // movieBloc.add(LoadMovies());
                            String movie = jsonEncode(state.movies[index].toJson());
                            context.goNamed(
                              'movie_details',
                              params: {'id': movie},
                            );
                        },
                            // context.go("/movie_details");
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                      "${ApiData.baseUrl}/${state.movies[index].imageUrl}"),),
                                color: Col.textColor),
                            width: 150,
                            margin: EdgeInsets.only(right: 10),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.favorite),
                                    color: Col.secondary,
                                    iconSize: 28,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(state.movies[index].title,
                                    style: TextStyle(
                                        color: Col.primary,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          );
        }

        return const Text("should never happen");
      },
    );
  }

  Widget buildSearch() => SearchWidget(
        text: "Search ...",
        hintText: 'Search ...',
      );
}
