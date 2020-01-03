import 'package:flutter/material.dart';
import 'package:librarian/screens/book_input.dart';

class AddScreen extends StatelessWidget {
  static const id = 'add_screen';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          child: Icon(
            Icons.add
          ),
        ),
        body: ListView(
        children: <Widget>[
          MyCard('Think and grow rich',(){
                Navigator.pushNamed(context, BookInput.id);
          }),
          MyCard('Think and grow rich',(){

          }),
          MyCard('Think and grow rich',(){

          })
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
