import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  static const id = 'search_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amberAccent,
        appBar: AppBar(
          title: TextField(
            decoration: InputDecoration(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),

            ),
            onChanged: (value) {
//                    print(value);
            },
          ),
        ),

      ),
    );
  }
}
