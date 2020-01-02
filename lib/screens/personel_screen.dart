import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PersonalScreen extends StatelessWidget {
  static const String id="personel_screen.dart";
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
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(FontAwesomeIcons.barcode),
              backgroundColor: Colors.red,
              label: 'Barcode',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => print('Barcode')
          ),
          SpeedDialChild(
            child: Icon(FontAwesomeIcons.search),
            backgroundColor: Colors.blue,
            label: 'From the web',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('From the web'),
          ),
          SpeedDialChild(
            child: Icon(FontAwesomeIcons.pen),
            backgroundColor: Colors.green,
            label: 'Manually',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('Manually'),
          ),
          SpeedDialChild(
            child: Icon(Icons.keyboard_voice),
            backgroundColor: Colors.green,
            label: 'ISBN',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('ISBN'),
          )
        ],
      ),
    );
  }
}
