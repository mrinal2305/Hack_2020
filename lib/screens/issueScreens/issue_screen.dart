import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:librarian/constants.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:librarian/elements/round_icon_button.dart';
import 'package:librarian/screens/issueScreens/student_info.dart';
import 'package:librarian/services/firebase_helpers.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class IssueScreen extends StatefulWidget {
  static const id = 'issue_screen';

  @override
  _IssueScreenState createState() => _IssueScreenState();
}

class _IssueScreenState extends State<IssueScreen> {
  final rollController = TextEditingController();
  String roll;
  bool isVisible = false;
  bool showSpinner=false;

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
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
//    setState(() {
//      showSpinner=false;
//    });
  }
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                'images/back.jpeg',
                fit: BoxFit.fill,
              ),
            ),
            Scaffold(
              backgroundColor: Color(0xd5ffffff),
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
                      onChanged: (value){
                        setState(() {
                          isVisible=false;
                        });
                      },
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
                    onPress: () async {
                      setState(() {
                        isVisible = false;
                        showSpinner=true;
                      });
                      roll = rollController.text;
                      print(roll);
                      bool isStu = await DatabaseService().isStudent(roll);
                      if (isStu)
                        Navigator.pushNamed(context, StudentInfo.id,
                            arguments: roll);
                      else {
                        setState(() {
                          isVisible = true;
                          showSpinner=false;
                        });
                      }
                    },
                  ),
                  Visibility(
                    visible: isVisible,
                    child: Padding(
                      padding:  EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          'Student Not registered',
                          style: kTitleTextStyle.copyWith(
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
