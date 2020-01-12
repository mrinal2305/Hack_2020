import 'package:flutter/material.dart';
import 'package:librarian/screens/addScreens/add_book_screen.dart';
import 'package:librarian/screens/home_screen.dart';
import 'package:librarian/screens/issue_screen.dart';
import 'package:librarian/screens/login_screen.dart';
import 'package:librarian/screens/search_screen.dart';
import 'package:librarian/screens/student_info.dart';
import 'package:librarian/screens/welcome_screen.dart';
import 'package:librarian/screens/addScreens/book_input.dart';
import 'package:barcode_scan/barcode_scan.dart';

void main() {
  runApp(MyApp());
}

//class MyApp1 extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: Container(
//        color: Colors.yellowAccent,
//        child:FlatButton(
//          child: Text('Press'),
//          color: Colors.red,
//          onPressed: ()async{
//            String qrResult = await BarcodeScanner.scan();
//            print(qrResult);
//          },
//        ),
//      ),
//    );
//  }
//}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: HomeScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        AddBookScreen.id: (context) => AddBookScreen(),
        BookInput.id: (context) => BookInput(),
        IssueScreen.id: (context) => IssueScreen(),
        StudentInfo.id: (context) => StudentInfo(),
        SearchScreen.id: (context) => SearchScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
      },
    );
  }
}
