import 'package:flutter/material.dart';
import 'package:librarian/constants.dart';
import 'package:librarian/elements/round_icon_button.dart';
import 'package:librarian/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  static const id = 'login_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
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
                  padding:
                      EdgeInsets.only(left: 8.0, top: 32, right: 8, bottom: 8),
                  child: Container(
                    color: Colors.white70,
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: kTextFieldDecoration.copyWith(
//                          icon: Icon(Icons.email),
                          hintText: 'Enter your User ID'
                      ),
                      onChanged: (value) {
//                    print(value);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 8.0, top: 8, right: 8, bottom: 32),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: kTextFieldDecoration.copyWith(
//                        icon: Icon(Icons.lock_outline),
                        hintText: 'Enter your Password',
                      ),
                      onChanged: (value) {
//                    print(value);
                      },
                    ),
                  ),
                ),
                RoundIconButton(
                  title: 'SIGN IN',
                  onPress: () {
                    Navigator.pushNamed(context, HomeScreen.id);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
