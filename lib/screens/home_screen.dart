import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:librarian/constants.dart';
import 'package:librarian/screens/addScreens/add_book_screen.dart';
import 'package:librarian/screens/issueScreens/issue_screen.dart';
import 'package:librarian/screens/search_screen.dart';
import 'package:librarian/elements/custom_cards.dart';

class HomeScreen extends StatelessWidget {
  static const id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: ()async=>false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            title: Text('Home'),
          ),
          drawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
//                curve: Curves.easeInCubic,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('Profile'),
                      Flexible(
                        child: Image.asset('images/personal.png'),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Text('Name'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Post'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          body: Container(
            height: data.size.height,
            width: data.size.width,
            margin: EdgeInsets.only(top: data.size.height / 7),
            decoration: BoxDecoration(
                color: Color(0xfff7f7f7),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(100))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                HomeCard('Add\nBook', () {
                  Navigator.pushNamed(context, AddBookScreen.id);
                }, 'images/book1.png'),
                HomeCard('Issue\nReissue\nReturn', () {
                  Navigator.pushNamed(context, IssueScreen.id);
                }, 'images/book2.png'),
                HomeCard('Search', () {
                  Navigator.pushNamed(context, SearchScreen.id);
                }, 'images/loupe2.png')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
