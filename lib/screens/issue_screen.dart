import 'package:flutter/material.dart';
import 'package:librarian/constants.dart';
import 'package:librarian/screens/student_info.dart';

class IssueScreen extends StatelessWidget {
  static const id = 'issue_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text('Issue'),
        ),
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Student',
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: kTextFieldDecoration.copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                            onPressed: (){
//                            Navigator.pushNamed(context, StudentInfo.id);
                            },
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
