import 'package:flutter/material.dart';

class IssueScreen extends StatelessWidget {
  static const id = 'issue_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.teal,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Student',),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    onChanged: (value){

                    },
                  ),
                ),
                IconButton(
                  onPressed: (){

                  },
                  icon: Icon(
                    Icons.search
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
