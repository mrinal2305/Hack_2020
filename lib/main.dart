import 'package:flutter/material.dart';
import 'package:lbs/providers/saved_books.dart';
import 'package:lbs/screens/login_screen.dart';
import 'package:lbs/screens/home_screen.dart';
import 'package:lbs/screens/personel_screen.dart';
import 'package:lbs/screens/search_screen.dart';
import 'package:lbs/screens/pdfViewer.dart';
import 'package:lbs/screens/book_input.dart';
import 'package:lbs/screens/issued_books_screens.dart';
import 'package:lbs/screens/saved_books/personal_book_screen.dart';
import 'package:lbs/elements/speech_to_text.dart';
import 'package:lbs/screens/welcome_screen.dart';

import 'package:lbs/elements/file_picker.dart';
import 'package:provider/provider.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SavedBooks>(
      create: (context)=>SavedBooks(),
      child: MaterialApp(
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

          initialRoute: WelcomeScreen.id,
          routes: {
                   //SavedBooks.id: (context)=>SavedBooks(),

                   IssuedPage.id: (context) =>IssuedPage(),
                   LoginScreen.id: (context) =>LoginScreen(),
                   HomePage.id: (context) =>HomePage(),
                   AddBookScreen.id: (context)=>AddBookScreen(),
                   BookInput.id: (context) => BookInput(),
                   SearchBar.id: (context)=>SearchBar(),
                   PdfViewer.id: (context)=>PdfViewer(),
                   FilePickerDemo.id: (context) =>FilePickerDemo(),
                   BookListScreen.id: (context) =>BookListScreen(),
                   SpeechText.id: (context) =>SpeechText(),
                   WelcomeScreen.id: (context) =>WelcomeScreen(),


                   }),
    );
  }
}
