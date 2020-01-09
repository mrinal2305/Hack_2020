import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomSpeedDial extends StatelessWidget{

  final Function onPressedBarCode;
  CustomSpeedDial({this.onPressedBarCode});
  Future<String> createAlertDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text('Enter Book Title'),
              content: TextField(
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
              ]);
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
//            label: 'First',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () {
            createAlertDialog(context).then(onPressedBarCode);
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.edit),
          backgroundColor: Colors.blue,
//          label: 'Second',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () {
//            var bookTitle = Navigator.pushNamed(context, AddBookManually.id);
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.keyboard_voice),
          backgroundColor: Colors.green,
//          label: 'Third',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => print('THIRD CHILD'),
        ),
      ],
    );
  }
}
