//import 'package:flutter/material.dart';
//import 'package:lbs/constants.dart';
//import 'package:lbs/elements/round_icon_button.dart';
//import 'package:lbs/screens/home_screen.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:lbs/services/firebase_helpers.dart';
//import 'package:modal_progress_hud/modal_progress_hud.dart';
//
//class LoginScreen extends StatefulWidget {
//  static const id = 'login_screen';
//
//  @override
//  _LoginScreenState createState() => _LoginScreenState();
//}
//
//class _LoginScreenState extends State<LoginScreen> {
////  final _auth = FirebaseAuth.instance;
////
//  bool isInvalid=false;
//  String validity='validity';
//  String email;
//  String password;
//  bool showSpinner = false;
//
//  @override
//  Widget build(BuildContext context) {
//    return SafeArea(
//      child: Scaffold(
//        body: ModalProgressHUD(
//          inAsyncCall: showSpinner,
//          child: Container(
//            child: Center(
//              child: SingleChildScrollView(
//                child: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    Text(
//                      'Sign in to Librarian',
//                      style: TextStyle(
//                        color: Color(0xff3ab397),
//                        fontWeight: FontWeight.bold,
//                        fontSize: 30,
//                      ),
//                    ),
//                    Padding(
//                      padding: EdgeInsets.only(
//                          left: 8.0, top: 32, right: 8, bottom: 8),
//                      child: Container(
//                        color: Colors.white70,
//                        padding: EdgeInsets.symmetric(horizontal: 30.0),
//                        child: TextField(
//                          textAlign: TextAlign.center,
//                          decoration: kTextFieldDecoration.copyWith(
////                          icon: Icon(Icons.email),
//                              hintText: 'Enter your User ID'),
//                          onChanged: (value) {
////                    print(value);
//                            email = value;
//                          },
//                        ),
//                      ),
//                    ),
//                    Padding(
//                      padding: EdgeInsets.only(
//                          left: 8.0, top: 8, right: 8, bottom: 32),
//                      child: Container(
//                        padding: EdgeInsets.symmetric(horizontal: 30.0),
//                        child: TextField(
////                      obscureText: true,
//                          textAlign: TextAlign.center,
//                          decoration: kTextFieldDecoration.copyWith(
////                        icon: Icon(Icons.lock_outline),
//                            hintText: 'Enter your Password',
//                          ),
//                          onChanged: (value) {
////                    print(value);
//                            password = value;
//                          },
//                        ),
//                      ),
//                    ),
//                    RoundIconButton(
//                      title: 'SIGN IN',
//                      onPress: () async {
//                        setState(() {
//                          showSpinner = true;
//                        });
//                        print(email);
//                        print(password);
//                        try{
//                          print('helloow1');
//                          User toNavigate= await AuthService().validate(email,password);
//                          print('hello');
////                         print('hello here $toNavigate');
//                          if(toNavigate.isUserAvailable&&toNavigate.isLibrarian) {
//                            Navigator.pushNamed(context, HomePage.id);
//                          } else{
//                            setState(() {
//                              if(toNavigate.errorType==null)
//                                validity='You are not authorized Librarian';
//                              validity=toNavigate.errorType;
//                              isInvalid=true;
//                            });
//                          }
//                          setState(() {
//                            showSpinner=false;
//                          });
//                        } catch(e){
//                          setState(() {
//                            showSpinner=false;
//                          });
//                          print('here in email sign in exception');
//                          print(e);
//                          print('outro signin in login');
//                        }
//                      },
//                    ),
//                    Visibility(
//                      child: Center(
//                        child: Text(
//                          validity,
//                          style: TextStyle(
//                            color: Color(0xff3ab397),
//                            fontWeight: FontWeight.bold,
//                            fontSize: 20,
//                          ),
//                        ),
//                      ),
//                      visible: isInvalid,
//                    ),
//                  ],
//                ),
//              ),
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}
