import 'package:flutter/material.dart';
import 'package:lbs/screens/home_screen.dart';
import 'package:lbs/screens/login_screen.dart';
import 'package:lbs/screens/home_screen2.dart';
import 'package:lbs/screens/personel_screen.dart';

import 'screens/personel_screen.dart';
import 'screens/personel_screen.dart';
import 'screens/personel_screen.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            accentColor: Colors.orange,
            cursorColor: Colors.orange,
            textTheme: TextTheme(
              display2: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 45.0,
                color: Colors.orange,
              ),
              button: TextStyle(
                fontFamily: 'OpenSans',
              ),
              subhead: TextStyle(fontFamily: 'NotoSans'),
              body1: TextStyle(fontFamily: 'NotoSans'),
            ),
          ),

        initialRoute: PersonalScreen.id,
        routes: {HomeScreen.id: (context) => HomeScreen(),
                 LoginScreen.id: (context) =>LoginScreen(),
                 HomePage.id: (context) =>HomePage(),
                 PersonalScreen.id: (context)=>PersonalScreen()

                 });
  }
}
