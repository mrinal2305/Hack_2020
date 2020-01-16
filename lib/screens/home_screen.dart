import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:librarian/screens/addScreens/add_book_screen.dart';
import 'package:librarian/screens/issue_screen.dart';
import 'package:librarian/screens/search_screen.dart';
import 'package:librarian/elements/my_card.dart';

class HomeScreen extends StatelessWidget {
  static const id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff3ab397),
//        appBar: AppBar(
//          title: Text('Home'),
//        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Drawer Header'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Item 2'),
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
          margin: EdgeInsets.only(top: data.size.height / 6),
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
              MyCard('Add\nBook', () {
                Navigator.pushNamed(context, AddBookScreen.id);
              }, 'images/collaboration.png'),
              MyCard('Issue\nReissue\nReturn', () {
                Navigator.pushNamed(context, IssueScreen.id);
              }, 'images/collaboration.png'),
              MyCard('Search', () {
//                    Navigator.pushNamed(context, SearchScreen.id);
              }, 'images/collaboration.png')
            ],
          ),
        ),
      ),
    );
  }
}
