import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:royal_cinema/features/mobile_staff/movie/index.dart';
import 'package:royal_cinema/core/staff_core/api_data.dart';
import 'package:royal_cinema/core/staff_core/colors.dart';
import 'package:royal_cinema/core/staff_core/search_widget.dart';
class MovieListScreen extends StatelessWidget {
  MovieListScreen({Key? key}) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    // Widget buildSearch() => SearchWidget(
    //       text: "Search ...",
    //       hintText: 'Search ...',
    //     );

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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // buildSearch(),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(color: Col.background),
                child: ListView.builder(
                    itemCount: state.movies.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Col.background),
                          margin: EdgeInsets.only(right: 10),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () => context.go('/MovieDetail',
                                      extra: state.movies[index]),
                                  child: Expanded(
                                    child: Image.network(
                                      '${apiData.baseUrl}//${state.movies[index].imageUrl!}',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ]),
          );
        }
        print(state);
        return const Text("should never happen");
      },
    );
  }
}
