import 'package:flutter/material.dart';
import 'package:lbs/constants.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () {
//                    Navigator.push(context, route)
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                         Image.asset('images/book.png'),
                          Text('Library Books'),
                        ],
                      ),
                    ),
                    color: kSecondaryColor,
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Text('Personel Books'),
                      ],
                    ),
                  ),
                  color: kSecondaryColor,
                ),
              ),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Text('Search from the Library'),
                      ],
                    ),
                  ),
                  color: kSecondaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
