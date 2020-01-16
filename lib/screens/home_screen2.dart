//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:lbs/elements/my_card.dart';
import 'package:lbs/screens/issued_books_screens.dart';
import 'package:lbs/screens/personel_screen.dart';
import 'package:lbs/constants.dart';
class HomePage extends StatelessWidget {
  static const id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    final data=MediaQuery.of(context);
    return Scaffold(

      backgroundColor: kPrimaryColor,
        appBar: AppBar(
          title: Text('Home'),
          backgroundColor: kPrimaryColor,
        ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(''),
              decoration: BoxDecoration(
                color: kPrimaryColor,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
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
