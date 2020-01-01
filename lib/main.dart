import 'package:flutter/material.dart';
import 'package:lbs/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          textTheme: TextTheme(
            body1: TextStyle(color: Colors.black),
          ),
        ),
        initialRoute: HomeScreen.id,
        routes: {HomeScreen.id: (context) => HomeScreen()});
  }
}
