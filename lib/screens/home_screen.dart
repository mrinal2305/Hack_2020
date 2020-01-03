import 'package:flutter/material.dart';
import 'package:librarian/screens/add_screen.dart';
import 'package:librarian/screens/issue_screen.dart';

class HomeScreen extends StatelessWidget {
  static const id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
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
              () {},
            ),
          ],
        ),
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  final String title;
  final Function onTap;

  MyCard(this.title, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Container(
          height: 180,
          width: 350,
          child: Text(title),
        ),
        color: Colors.blue,
      ),
    );
  }
}
