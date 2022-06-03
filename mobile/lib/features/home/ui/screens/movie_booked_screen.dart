// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:royal_cinema/core/api_data.dart';
import 'package:royal_cinema/core/utils/colors.dart';
import 'package:royal_cinema/features/home/bloc/bloc.dart';

class BookedMovieScreen extends StatefulWidget {
  const BookedMovieScreen({Key? key}) : super(key: key);

  @override
  _BookedMovieScreenState createState() => _BookedMovieScreenState();
}

class _BookedMovieScreenState extends State<BookedMovieScreen> {
  bool more = false;

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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "Watch List",
                  style: TextStyle(
                      color: Col.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  color: Col.secondary,
                  child: ListView.builder(
                    itemCount: state.movies.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        color: Col.textColor,
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                        ),
                        elevation: 8,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: more
                              ? Stack(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              "${ApiData.baseUrl}/${state.movies[index].imageUrl}"),
                                        ),
                                      ),
                                      width: double.infinity,
                                      height: 200,
                                    ),
                                    Container(
                                      // margin: EdgeInsets.only(top: 10),
                                      width: double.infinity,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        color: Col.background.withOpacity(0.5),
                                        // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                                      ),
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 10, 0, 10),
                                            child: Text(
                                              state.movies[index].title,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Align(
                                            child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  more = !more;
                                                });
                                              },
                                              icon: Icon(Icons
                                                  .keyboard_arrow_down_sharp),
                                              iconSize: 30,
                                              color: Colors.black,
                                            ),
                                            alignment: Alignment.topRight,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 50, 0, 10),
                                            child: Text(
                                              state.movies[index].description,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0.1,
                                            left: 10,
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Rating : ",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(Icons.star),
                                                  color: Col.primary,
                                                ),
                                                IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(Icons.star),
                                                  color: Col.primary,
                                                ),
                                                IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(Icons.star),
                                                  color: Col.primary,
                                                ),
                                                IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(Icons.star),
                                                  color: Col.primary,
                                                ),
                                                IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(Icons.star),
                                                  color: Col.primary,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              "${ApiData.baseUrl}/${state.movies[index].imageUrl}"),
                                        ),
                                      ),
                                      width: double.infinity,
                                      height: 160,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Col.background,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(8)),
                                      ),
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 10, 0, 10),
                                            child: Text(
                                              state.movies[index].title,
                                              style: TextStyle(
                                                  color: Col.textColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Align(
                                            child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  more = !more;
                                                });
                                              },
                                              icon: Icon(Icons
                                                  .keyboard_arrow_up_sharp),
                                              iconSize: 30,
                                              color: Colors.black,
                                            ),
                                            alignment: Alignment.bottomRight,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }

        return const Text("should never happen");
      },
    );
  }

// Widget WatchList() {
//
//   bool more = false;
//
//   return Card(
//       margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
//       color: Col.textColor,
//       shape: BeveledRectangleBorder(
//         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
//       ),
//       elevation: 8,
//       child: Padding(
//         padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//         child: more ? Stack(
//           children: <Widget>[
//             Container(
//               child: SvgPicture.asset('images/Parking-amico.svg'),
//               width: 400,
//               height: 160,
//             ),
//             Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Col.background,
//                 borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
//               ),
//               child: Stack(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
//                     child: Text("Ye wendoch guday",
//                       style: TextStyle(
//                           color: Col.textColor,
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500
//                       ),
//                     ),
//                   ),
//                   Align(
//                     child: IconButton(
//                       onPressed: () {
//                         setState(() {
//                           more = !more;
//                         });
//                       },
//                       icon: Icon(Icons.keyboard_arrow_down_sharp),
//                       iconSize: 30,
//                       color: Colors.black,
//                     ),
//                     alignment: Alignment.bottomRight,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ) : Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Container(
//               child: SvgPicture.asset('images/Parking-amico.svg'),
//               width: 400,
//               height: 160,
//             ),
//             Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Col.background,
//                 borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
//               ),
//               child: Stack(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
//                     child: Text("Ye wendoch guday",
//                       style: TextStyle(
//                           color: Col.textColor,
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500
//                       ),
//                     ),
//                   ),
//                   Align(
//                     child: IconButton(
//                       onPressed: () {
//                         setState(() {
//                           more = !more;
//                         });
//                       },
//                       icon: Icon(Icons.keyboard_arrow_up_sharp),
//                       iconSize: 30,
//                       color: Colors.black,
//                     ),
//                     alignment: Alignment.bottomRight,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//   );
//   //   Container(
//   //   decoration: BoxDecoration(
//   //       borderRadius: BorderRadius.circular(8),
//   //       color: Col.textColor
//   //   ),
//   //   width: 150,
//   //   height: 100,
//   //   margin: EdgeInsets.fromLTRB(50, 10, 50, 0),
//   // );
// }
}
