import 'package:flutter/material.dart';
import 'package:librarian/screens/student_info.dart';

class IssueScreen extends StatelessWidget {
  static const id = 'issue_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(appBar: AppBar(
        title: Text('Issue'),
      ),
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
                      Navigator.pushNamed(context,StudentInfo.id);
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
