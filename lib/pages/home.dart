// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:royal_cinema/constants/colors.dart';
import 'package:royal_cinema/widget/search_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool liked = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSearch(),
          SizedBox(height: 5,),
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: Text("Today's",
            style: TextStyle(
              color: Col.textColor,
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              color: Col.secondary
            ),
            child: ListView.builder(
                itemCount: 20,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index){
                  return TodayView();
                }),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: Text("This Week",
              style: TextStyle(
                color: Col.textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            height: 400,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
                color: Col.secondary
            ),
            child: GridView.builder(
                itemCount: 20,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index){
                  return WeekView();
                }),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: Text("Upcoming",
              style: TextStyle(
                color: Col.textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            height: 280,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
                color: Col.secondary
            ),
            child: ListView.builder(
                itemCount: 20,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index){
                  return UpcomingView();
                }),
          ),
        ],
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
    text: "Search ...",
    hintText: 'Search ...',
  );

  Widget TodayView() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Col.textColor
      ),
      width: 150,
      margin: EdgeInsets.only(right: 10),
      child: Align(
        alignment: Alignment.topRight,
        child: IconButton(
          onPressed: (){
            setState(() {
              liked = !liked;
            });
          },
          icon: Icon(Icons.favorite),
          color: liked ? Col.secondary : Col.background,
          iconSize: 28,
        ),
      ),
    );
  }

  Widget WeekView() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Col.textColor
      ),
      width: 150,
      margin: EdgeInsets.only(right: 10, bottom: 10),
      child: Align(
        alignment: Alignment.topRight,
        child: IconButton(
          onPressed: (){
            setState(() {
              liked = !liked;
            });
          },
          icon: Icon(Icons.favorite),
          color: liked ? Col.secondary : Col.background,
          iconSize: 28,
        ),
      ),
    );
  }

  Widget UpcomingView() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Col.textColor
      ),
      width: 150,
      margin: EdgeInsets.only(right: 10),
      child: Align(
        alignment: Alignment.topRight,
        child: IconButton(
          onPressed: (){
            setState(() {
              liked = !liked;
            });
          },
          icon: Icon(Icons.favorite),
          color: liked ? Col.secondary : Col.background,
          iconSize: 28,
        ),
      ),
    );
  }

}