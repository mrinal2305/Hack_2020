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

String getStringFromDate(String date) {
  String temp = '';
  for (int i = 0; i < date.length; i++) {
    if (date[i] == ' ') {
      break;
    }
    temp += date[i];
  }
  return temp;
}

class MyApp1 extends StatelessWidget {
  void addFine() {
    DateTime now = DateTime.now();
    DateTime issue = DateTime(now.year, now.month, now.day);
    DateTime reissue = DateTime(now.year, now.month, now.day + 15);
    print(issue.toString());
    String issuedDate = issue.toString();
    String returnDate = reissue.toString();
    issuedDate = getStringFromDate(issuedDate);
    returnDate = getStringFromDate(returnDate);
    print(issuedDate);
    print(returnDate);
//    var id = 'sd';
//    var todayDate = [];
//    var retDate = [];
//    var books;
//    var db = Firestore.instance; //
//    final studentCollection = db.collection('student');
//    final students = await studentCollection.document(id).get();
////    print(students.data);
////    print(students.data['books'][0]['returnDate']);
//  print(students.data['issuedDate']);
  }

  void removeBookFromStudent() async {
    var roll = '1706011';

    Map issuedBook ;
    Firestore db = Firestore.instance;
    var book = await db.collection('student').document(roll).get();
//    print(issuedBook.data['books']);
    var l = book.data['books'];
    for (int i = 0; i < l.length; i++) {
//      print(l[i]);
//      print(l[i]['isbn']);
      if (l[i]['isbn'] == '123435225'){
//        print(l[i]['isbn']);
//        print(l[i]);
        issuedBook=l[i];
        print(issuedBook);
      }
    }
//    var roll = '1706011';
//    final studentCollection = db.collection('student');
//    await studentCollection.document(roll).updateData({
//      'books': FieldValue.arrayRemove([issuedBook])
//    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        color: Colors.yellowAccent,
        child: FlatButton(
          child: Text('Press'),
          color: Colors.red,
          onPressed: () {
//            DatabaseService().updateBookData('123435225');
//            String qrResult = await BarcodeScanner.scan();
//            print(qrResult);
//            DatabaseService().getNlpData();
//            addFine();
            removeBookFromStudent();
          },
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
      initialRoute: HomeScreen.id,
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
