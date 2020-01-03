import 'package:flutter/material.dart';

class StudentInfo extends StatelessWidget {
  static const id = 'student_info';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lightGreenAccent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Student Info'),
            CustomWidget(),
          ],
        ),
      ),
    );
  }
}

class CustomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 150,
          height: 100,
        child: Text('hello'),
      ),
    );
  }
}
