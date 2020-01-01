import 'package:flutter/material.dart'

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark().copyWith(
      textTheme: TextTheme(
        body1: TextStyle(color: Colors.black54),
      ),
    ),
    initialRoute: HomeScreen.id,
    routes:{
          HomeScreen.id:(context)=>HomeScreen()
    }
    );

}
