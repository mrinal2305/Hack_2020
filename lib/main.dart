import 'package:flutter/material.dart';
import 'package:librarian/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
//        HomeScreen.id: (context) => HomeScreen(),
//        HomePage.id: (context) => HomePage(),
//        PersonalScreen.id: (context) => PersonalScreen()
      },
    );
  }
}
