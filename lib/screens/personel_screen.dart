import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';

class PersonalScreen extends StatelessWidget {
  static const String id="personel_screen.dart";

  Future<String> createAlertDialog(BuildContext context){
    TextEditingController customController =TextEditingController();
    return showDialog(context: context,builder: (context){
      return AlertDialog(
          title: Text('ISBN'),
          content: TextField(
            controller: customController,
          ),
          actions:<Widget>[
            MaterialButton(
              elevation: 5.0,
              child: Text('Submit'),
              onPressed: (){
                Navigator.of(context).pop(customController.text.toString());
              },
            )
          ]
      );});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        // both default to 16
        marginRight: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        // this is ignored if animatedIcon is non null
        // child: Icon(Icons.add),
        //visible: _dialVisible,
        // If true user is forced to close dial manually
        // by tapping main button and overlay is not rendered.
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        //onOpen: () => print('OPENING DIAL'),
        //onClose: () => print('DIAL CLOSED'),
        //tooltip: 'Speed Dial',
        //heroTag: 'speed-dial-hero-tag',
        backgroundColor: Color(0xFF21BFBD),
        foregroundColor: Colors.white,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(FontAwesomeIcons.barcode),
              backgroundColor: Color(0x9521BFBD),
              label: 'Barcode',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: (){}
          ),
          SpeedDialChild(
            child: Icon(FontAwesomeIcons.search),
            backgroundColor: Color(0x9521BFBD),
            label: 'From the web',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: (){}
          ),
//          SpeedDialChild(
//            child: Icon(FontAwesomeIcons.pen),
//            backgroundColor: Color(0x9521BFBD),
//            label: 'Manually',
//            labelStyle: TextStyle(fontSize: 18.0),
//            onTap: (){}
//          ),
          SpeedDialChild(
            child: Icon(Icons.keyboard_voice),
            backgroundColor: Color(0x9521BFBD),
            label: 'ISBN',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: (){
                createAlertDialog(context).then((onValue){
                     print(onValue);
                    });}

    ),
      ],
    ));
  }
}
