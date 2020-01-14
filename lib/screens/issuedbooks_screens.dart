import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class IssuedPage extends StatefulWidget {
  static const id="issuedbooks_screens.dart";
  @override
  _IssuedPageState createState() => _IssuedPageState();
}

class _IssuedPageState extends State<IssuedPage> {
  final databaseReference = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Scaffold(
          body: Column(
            children: <Widget>[
              FlatButton(

                child: Text(
                    'readData'
                ),
                onPressed: () {
                  getData();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void getData() {
    databaseReference
        .collection('student')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });
  }

}