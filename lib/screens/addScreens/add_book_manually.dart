import 'package:flutter/material.dart';
import 'package:librarian/constants.dart';
import 'package:librarian/screens/addScreens/add_book_screen.dart';


class AddBookManually extends StatefulWidget {
  static const id = 'add_book_manually';
  @override
  _AddBookManuallyState createState() => _AddBookManuallyState();
}

class _AddBookManuallyState extends State<AddBookManually> {
  String title;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff737373),
        body: Center(
          child: Container(
            height: 200,
            padding:  EdgeInsets.all(8.0),
            color: Colors.white,
            child: Center(
              child: TextField(
                onChanged: (value){
                  title=value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter book title',
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: (){
                      Navigator.pop(context,title);
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
