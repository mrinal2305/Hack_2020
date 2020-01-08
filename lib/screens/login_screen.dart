import 'package:flutter/material.dart';
import 'package:librarian/constants.dart';
import 'package:librarian/elements/round_icon_button.dart';
import 'package:librarian/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  String email;
  String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Sign in to Librarian',
                    style: TextStyle(
                      color: Color(0xff3ab397),
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 8.0, top: 32, right: 8, bottom: 8),
                    child: Container(
                      color: Colors.white70,
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: kTextFieldDecoration.copyWith(
//                          icon: Icon(Icons.email),
                            hintText: 'Enter your User ID'),
                        onChanged: (value) {
//                    print(value);
                          email = value;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 8.0, top: 8, right: 8, bottom: 32),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextField(
//                      obscureText: true,
                        textAlign: TextAlign.center,
                        decoration: kTextFieldDecoration.copyWith(
//                        icon: Icon(Icons.lock_outline),
                          hintText: 'Enter your Password',
                        ),
                        onChanged: (value) {
//                    print(value);
                          password = value;
                        },
                      ),
                    ),
                  ),
                  RoundIconButton(
                    title: 'SIGN IN',
                    onPress: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      print(email);
                      print(password);
                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        if (user != null) {
                          Navigator.pushNamed(context, HomeScreen.id);
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        setState(() {
                          showSpinner = false;
                        });
                        print('here in exception');
                        print(e);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
