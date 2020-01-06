import 'package:flutter/material.dart';
import 'package:lbs/elements/my_card.dart';

class HomePage extends StatelessWidget {
  static const id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3ab397),
//        appBar: AppBar(
//          title: Text('Home'),
//        ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 100),
        decoration: BoxDecoration(
            color: Color(0xfff7f7f7),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(100))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyCard('Library',(){},'images/libr.png'),
            MyCard('Personal',(){},'images/personal.png'),

            MyCard('Search',(){},'images/search.png'),
          ],
        ),
      ),
    );
  }
}
