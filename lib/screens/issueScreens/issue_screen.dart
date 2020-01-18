import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:librarian/constants.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:librarian/elements/round_icon_button.dart';
import 'package:librarian/screens/issueScreens/student_info.dart';

class IssueScreen extends StatefulWidget {
  static const id = 'issue_screen';

  @override
  _IssueScreenState createState() => _IssueScreenState();
}

class _IssueScreenState extends State<IssueScreen> {
  final rollController = TextEditingController();
  String roll;

  void getRollByBar() async {
    try {
      String result = await BarcodeScanner.scan();
      rollController.text = result;
      rollController.selection = TextSelection.fromPosition(
          TextPosition(offset: rollController.text.length));

      print(result);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        print('camera acces denied');
      } else {
        print(e);
      }
    } on FormatException {
      print('You pressed the back button before scanning anything');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            child: Image.asset(
              'images/back.jpeg',
              fit: BoxFit.fill,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              title: Text('Issue Screen'),
            ),
            body: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: rollController,
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter Roll or Search by Barcode',
                      hintMaxLines: 2,
                      suffixIcon: IconButton(
                        onPressed: () {
                          getRollByBar();
                        },
                        icon: Icon(
                          FontAwesomeIcons.barcode,
                        ),
                      ),
                    ),
                  ),
                ),
                RoundIconButton(
                  title: 'Search',
                  onPress: () {
                    roll = rollController.text;
                    print(roll);
                    Navigator.pushNamed(context, StudentInfo.id,
                        arguments: roll);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
