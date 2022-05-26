// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:royal_cinema/constants/colors.dart';

class Booked extends StatefulWidget {
  const Booked({Key? key}) : super(key: key);

  @override
  _BookedState createState() => _BookedState();
}

class _BookedState extends State<Booked> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10,),
        Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text("Watch List",
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
                  return WatchList();
                },
              ),
            ),
        ),
      ],
    );
  }

  Widget WatchList() {
    return GestureDetector(
      onTap: () {
      },
      child: Card(
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
              SizedBox(height: 160,),
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
                      child: Text("Ye wendoch guday",
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
      ),
    );
    //   Container(
    //   decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(8),
    //       color: Col.textColor
    //   ),
    //   width: 150,
    //   height: 100,
    //   margin: EdgeInsets.fromLTRB(50, 10, 50, 0),
    // );
  }
}