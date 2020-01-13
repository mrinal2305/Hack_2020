//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:lbs/elements/my_card.dart';
import 'package:lbs/screens/issuedbooks_screens.dart';
import 'package:lbs/screens/personel_screen.dart';
class HomePage extends StatelessWidget {
  static const id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    final data=MediaQuery.of(context);
    return Scaffold(

      backgroundColor: Color(0xff3ab397),
//        appBar: AppBar(
//          title: Text('Home'),
//        ),
      body: Container(
        height: data.size.height,
        width: data.size.width,
        margin: EdgeInsets.only(top: data.size.height/6),
        decoration: BoxDecoration(
            color: Color(0xfff7f7f7),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(100))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyCard('Library',(){
              Navigator.pushNamed(context,IssuedPage.id );
            },'images/libr.png',),
            MyCard('Personal',(){
              Navigator.pushNamed(context,AddBookScreen.id);
            },'images/personal.png'),

            MyCard('Search',(){},'images/search.png'),
          ],
        ),
      ),
    );
  }
}
