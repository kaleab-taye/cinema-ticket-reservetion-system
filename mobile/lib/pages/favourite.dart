// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:royal_cinema/constants/colors.dart';

class Favourite extends StatelessWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10,),
        Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text("Favourite List",
            style: TextStyle(
                color: Col.textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        SizedBox(height: 10,),
        Expanded(
          child: Container(
            color: Col.secondary,
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  color: Col.textColor,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                  ),
                  elevation: 8,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Image.asset('images/60578.jpg'),
                          width: double.infinity,
                          height: 160,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Col.background,
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                          ),
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                                child: Text("The Dark Knight",
                                  style: TextStyle(
                                      color: Col.textColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                              Align(
                                child: IconButton(
                                  onPressed: () {
                                  },
                                  icon: Icon(Icons.keyboard_arrow_up_sharp),
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
}
