import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  final Function onPress;
  final String title;

  RoundIconButton({@required this.title, @required this.onPress});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: onPress,
      elevation: 6.0,
      constraints: BoxConstraints.tightFor(
        width: 200.0,
        height: 56.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      fillColor: Color(0xff3ab397),
    );
  }
}
