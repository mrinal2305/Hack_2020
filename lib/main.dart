import 'package:flutter/material.dart';
import 'package:librarian/screens/addScreens/add_book_screen.dart';
import 'package:librarian/screens/home_screen.dart';
import 'package:librarian/screens/issueScreens/book_issue.dart';
import 'package:librarian/screens/issueScreens/issue_screen.dart';
import 'package:librarian/screens/login_screen.dart';
import 'package:librarian/screens/search_screen.dart';
import 'package:librarian/screens/issueScreens/student_info.dart';
import 'package:librarian/screens/issueScreens/student_info.dart';
import 'package:librarian/screens/welcome_screen.dart';
import 'package:librarian/screens/addScreens/book_input.dart';
import 'package:librarian/services/firebase_helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp1 extends StatefulWidget {
  @override
  _MyApp1State createState() => _MyApp1State();
}

class _MyApp1State extends State<MyApp1> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: IconButton(
            icon: Icon(Icons.add,
            color: Colors.red,),
              onPressed: ()async{
              await DatabaseService().getBookData();
              },
          ),
        ),
      ),
    );
  }
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
      initialRoute: WelcomeScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        AddBookScreen.id: (context) => AddBookScreen(),
        BookInput.id: (context) => BookInput(),
        IssueScreen.id: (context) => IssueScreen(),
        StudentInfo.id: (context) => StudentInfo(),
        BookIssue.id: (context) => BookIssue(),
        SearchScreen.id: (context) => SearchScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
      },
    );
  }
}
