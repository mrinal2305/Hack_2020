import 'package:flutter/material.dart';

class BookInput extends StatelessWidget {
  static const id = 'book_input';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Flexible(
                    child: Image(
                      image: AssetImage('images/collaboration.png'),
                    ),
                  ),
                  Text('book details'),
                ],
              ),
              CircleAvatar(
                backgroundColor: Colors.red,
                child: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  color: Colors.black,
                  icon: Icon(
                    Icons.add
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
