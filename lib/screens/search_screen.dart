import 'package:flutter/material.dart';
import 'package:librarian/constants.dart';

class SearchScreen extends StatelessWidget {
  static const id = 'search_screen';
  String searchQuery;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          title: TextField(
            decoration: kTextFieldDecoration.copyWith(
              hintText: 'Enter book title',
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: (){
                  print(searchQuery);
                },
              ),
            ),
            onChanged: (value) {
              searchQuery=value;
            },
          ),
        ),

      ),
    );
  }
}
