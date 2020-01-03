import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            MyCard('Add\nBook'),
            MyCard('Issue\nReissue\nReturn'),
            MyCard('Search'),
          ],
        ),
      ),
    );
  }
}


class MyCard extends StatelessWidget {
  final String title;
  MyCard(this.title);
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
          height: 180,
            width: 350,
            child: Text(title),
        ),
      color: Colors.blue,
    );
  }
}
