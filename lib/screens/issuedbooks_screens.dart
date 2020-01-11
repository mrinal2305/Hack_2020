import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


class IssuedPage extends StatefulWidget {
  static const id="issuedbooks_screens.dart";
  @override
  _IssuedPageState createState() => _IssuedPageState();
}

class _IssuedPageState extends State<IssuedPage> {
  final db = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            FlatButton(

              child: Text(
                  'readData'
              ),
              onPressed: () {
                readData();
              },
            )
          ],
        ),
      ),
    );
  }

  void readData() {
    db.once().then((DataSnapshot datasnaphot) {
      print(datasnaphot.value);
    }
    );
  }

}