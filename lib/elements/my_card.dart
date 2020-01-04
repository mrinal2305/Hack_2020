import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final String title;
  final Function onTap;

  MyCard(this.title, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
//        borderOnForeground: false,
        child: Container(
          margin: EdgeInsets.only(left: 8, top: 8, bottom: 8),
          padding: EdgeInsets.all(8),
          child: Row(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset('images/collaboration.png'),
              SizedBox(
                width: 40,
              ),
              Text(title),
            ],
          ),
          height: 120.00,
          width: 300,
        ),
      ),
    );
  }
}
