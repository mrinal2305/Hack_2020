import 'package:flutter/material.dart';
import 'package:librarian/screens/add_screen.dart';
import 'package:librarian/screens/issue_screen.dart';
import 'package:librarian/screens/search_screen.dart';
import 'package:librarian/elements/my_card.dart';

class HomeScreen extends StatelessWidget {
  static const id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
//        appBar: AppBar(
//          title: Text('Home'),
//        ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 100),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(100))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyCard(
              'Add\nBook',
              () {
                Navigator.pushNamed(context, AddScreen.id);
              },
            ),
            MyCard(
              'Issue\nReissue\nReturn',
              () {
                Navigator.pushNamed(context, IssueScreen.id);
              },
            ),
            MyCard(
              'Search',
              () {
                Navigator.pushNamed(context, SearchScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
