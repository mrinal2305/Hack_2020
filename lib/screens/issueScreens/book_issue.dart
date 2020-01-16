import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:librarian/constants.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:librarian/elements/custom_cards.dart';
import 'package:librarian/elements/round_icon_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookIssue extends StatefulWidget {
  static const id = 'book_issue';

  @override
  _BookIssueState createState() => _BookIssueState();
}

class _BookIssueState extends State<BookIssue> {
  final isbnController = TextEditingController();
  String isbn;
  String title;
  String author;
  String imgUrl;

  void getBookIsbnByBar() async {
    try {
      String result = await BarcodeScanner.scan();
      isbnController.text = result;
      isbnController.selection = TextSelection.fromPosition(
          TextPosition(offset: isbnController.text.length));

      print(result);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        print('camera acces denied');
      } else {
        print(e);
      }
    } on FormatException {
      print('You pressed the back button before scanning anything');
    } catch (e) {
      print(e);
    }
  }

  //from firebase
  void getBookByIsbn() async {
    var db = Firestore.instance; //
    final bookCollection = db.collection('book');
    final books = await bookCollection.document(isbn).get();
    print(books.data);
    final bookData = books.data;
//    try {
    if (mounted)
      setState(() {
        title = bookData['title'];
        author = bookData['author'];
        imgUrl = bookData['smallThumbnails'];
      });
//    } catch (e) {
//      print('in getStudentByRoll ${e.message}');
//    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text('Book Issue'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: isbnController,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter ISBN or Search by Barcode',
                  hintMaxLines: 2,
                  suffixIcon: IconButton(
                    onPressed: () {
                      getBookIsbnByBar();
                    },
                    icon: Icon(
                      FontAwesomeIcons.barcode,
                    ),
                  ),
                ),
              ),
            ),
            RoundIconButton(
              title: 'Search',
              onPress: () {
                isbn = isbnController.text;
                print(isbn);
                getBookByIsbn();
              },
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: BookCard(
                      title: title,
                      isbn: isbn,
                      author: author,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: RoundIconButton(
                      width: double.infinity,
                      onPress: () {},
                      title: 'Add',
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
