import 'package:flutter/material.dart';
import 'package:librarian/screens/add_book_screen.dart';
import 'package:librarian/screens/issue_screen.dart';
import 'package:librarian/screens/search_screen.dart';
import 'package:librarian/elements/my_card.dart';

class HomeScreen extends StatelessWidget {
  static const id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Container(decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/login.png"), fit: BoxFit.cover),
        ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
//        appBar: AppBar(
//          backgroundColor: Colors.white,
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
          ),
        ),
      ),
    );
  }
}
