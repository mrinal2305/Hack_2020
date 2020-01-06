import 'package:flutter/material.dart';
import 'package:librarian/screens/book_input.dart';
import 'package:librarian/elements/my_card.dart';

class AddScreen extends StatelessWidget {
  static const id = 'add_book_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff3ab397),
          title: Text('Add Book'),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          child: Icon(Icons.add),
        ),
        body: ListView(
          children: <Widget>[
            MyCard('Think and grow rich', () {
              Navigator.pushNamed(context, BookInput.id);
            }),
            MyCard('Think and grow rich', () {}),
            MyCard('Think and grow rich', () {})
          ],
        ),
      ),
    );
  }
}
