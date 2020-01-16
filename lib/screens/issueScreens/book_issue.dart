import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:librarian/constants.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:librarian/elements/round_icon_button.dart';
import 'package:librarian/screens/issueScreens/student_info.dart';

class BookIssue extends StatefulWidget {
  static const id = 'book_issue';

  @override
  _BookIssueState createState() => _BookIssueState();
}

class _BookIssueState extends State<BookIssue> {
  final rollController = TextEditingController();
  String roll;
  void getBookIsbnByBar() async {
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
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text('Book Issue'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: rollController,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter ISBN or Search by Barcode',
                  hintMaxLines: 2,
                  suffixIcon: IconButton(
                    onPressed: () {
                      getBookIsbnByBar();
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
                roll=rollController.text;
                print(roll);
                Navigator.pushNamed(context, StudentInfo.id,arguments: roll);
              },
            ),
          ],
        ),
      ),
    );
  }
}
