import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lbs/constants.dart';
import 'package:lbs/elements/speech_to_text.dart';
import 'dart:async';

class CustomSpeedDial extends StatelessWidget {
  final Function onISBNPressed;
  final Function onTitlePressed;
  final Function onBarPressed;
  final Function onVoicePressed;

  CustomSpeedDial({this.onISBNPressed,this.onTitlePressed,this.onBarPressed,this.onVoicePressed});

  //Dialog box
  Future<String> createAlertDialog(
      BuildContext context, String heading, InputDecoration deco) {
    TextEditingController customController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(heading),
            content: TextField(
              decoration: deco,
              controller: customController,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text('Submit'),
                onPressed: () {
                  Navigator.of(context).pop(customController.text.toString());
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      // both default to 16
      marginRight: 18,
      marginBottom: 20,
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      // this is ignored if animatedIcon is non null
      // child: Icon(Icons.add),
      visible: true,
      // If true user is forced to close dial manually
      // by tapping main button and overlay is not rendered.
      closeManually: false,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      onOpen: () {},
      onClose: () {},
      tooltip: 'Speed Dial',
      heroTag: 'speed-dial-hero-tag',
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 8.0,
      shape: CircleBorder(),
      children: [
        //Manual adding book
        SpeedDialChild(
          child: Icon(Icons.edit),
          backgroundColor: Colors.red,
//            label: 'First',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () {
            createAlertDialog(
              context,
              'Enter Book Title',
              kTextFieldDecoration.copyWith(
                hintText: 'Book Title required',
              ),
            ).then(onTitlePressed);
          },
        ),
        //Adding book by barcode
        SpeedDialChild(
          child: Icon(FontAwesomeIcons.barcode),
          backgroundColor: Colors.blueGrey,
//          label: 'Second',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: onBarPressed,
        ),
        //adding book by speech
        SpeedDialChild(

          child: Icon(Icons.keyboard_voice),
          backgroundColor: Colors.green,
//          label: 'Third',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: onVoicePressed,

        ),
        //adding book by ISBN
        SpeedDialChild(
          child: Icon(Icons.dialpad),
          backgroundColor: Colors.teal,
          onTap: () {
            createAlertDialog(
              context,
              'Enter ISBN Number',
              kTextFieldDecoration.copyWith(
                hintText: 'ISBN Number required',
              ),
            ).then(onISBNPressed);
          },
        ),

      ],
    );
  }
}