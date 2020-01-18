import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final title;
  final message;
  final Function onPress;
  CustomDialog({this.title,this.message,this.onPress});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.tealAccent,
      title: Text('$title'),
      content: Text('$message'),
      actions: <Widget>[
        MaterialButton(
          elevation: 5.0,
          child: Text('OK'),
          onPressed: onPress,
        ),
      ],
    );
  }
}

