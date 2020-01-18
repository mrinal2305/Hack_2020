import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:librarian/constants.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:librarian/elements/custom_cards.dart';
import 'package:librarian/elements/round_icon_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:librarian/elements/custom_dialog.dart';
import 'package:librarian/screens/home_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class BookIssue extends StatefulWidget {
  static const id = 'book_issue';

  @override
  _BookIssueState createState() => _BookIssueState();
}

class _BookIssueState extends State<BookIssue> {
  List<dynamic> rollAndOp = [];
  final isbnController = TextEditingController();
  String isbn;
  String title;
  String author;
  String imgUrl;
  String roll;

  var db = Firestore.instance; //
  bool isVisible = false;
  bool isError=false;
  bool showSpinner = false;

  String errorMessage;
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

  //used in removed book
  Future<Map> getIssuedBookByIsbn(String isbn) async {
    Map issuedBook;
    try {
      var book = await db.collection('student').document(roll).get();
//    print(issuedBook.data['books']);
      var l = book.data['books'];
      for (int i = 0; i < l.length; i++) {
//      print(l[i]);
//      print(l[i]['isbn']);
        if (l[i]['isbn'] == isbn) {
//        print(l[i]['isbn']);
//        print(l[i]);
          issuedBook = l[i];
          print(issuedBook);
          return issuedBook;
        }
      }
    } catch (e) {
      print('in issuedBookbyisbn');
    }
    setState(() {
      errorMessage='Not your book';
      isError=true;
    });
    return null;
  }

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

  String toIsbn10(String isbn){
    String temp='';
    for(int i=3;i<isbn.length;i++){
      temp+=isbn[i];
    }
    print('in toisbn10 $temp');
    return temp;
  }

  //from firebase
  void getBookByIsbn() async {
    final bookCollection = db.collection('book');
    var books;
    try {
         books = await bookCollection.document(isbn).get();

      print(books.data);
      final bookData = books.data;
//    try {
      if (mounted)
        setState(() {
          title = bookData['title'];
          author = bookData['author'];
          imgUrl = bookData['smallThumbnail']; //or check for smallThumbnails
          isVisible = true;
        });
//    } catch (e) {
//      print('in getStudentByRoll ${e.message}');
//    }
    } catch (e) {

      try {
        print('in isbn10');
        books = await bookCollection.document(toIsbn10(isbn)).get();
        final bookData = books.data;
//    try {
        if (mounted)
          setState(() {
            title = bookData['title'];
            author = bookData['author'];
            imgUrl = bookData['smallThumbnail']; //or check for smallThumbnails
            isVisible = true;
          });

//        print('This book is not available in library\n');
      } catch(e){
        setState(() {

          errorMessage='This book is not available in library';
          isError=true;
        });
      }
    }
  }

  void addBookToStudent() async {
    DateTime now = DateTime.now();
    DateTime issue = DateTime(now.year, now.month, now.day);
    DateTime reissue = DateTime(now.year, now.month, now.day + 15);
    print(issue.toString());
    String issuedDate = issue.toString();
    String returnDate = reissue.toString();
    issuedDate = getStringFromDate(issuedDate);
    returnDate = getStringFromDate(returnDate);
//    print(myDatetime.difference(mySecondDate).inDays.toString());
    print(issuedDate);
    print(returnDate);
    Map<String, String> issuedBook = {
      'smallThumbnail': imgUrl ?? imgIsNull,
      'isbn': isbn,
      'title': title,
      'author': author,
      'issueDate': issuedDate,
      'returnDate': returnDate,
    };
    print(issuedBook);
//    roll = '1706011';
    final studentCollection = db.collection('student');
    try {
      await studentCollection.document(roll).updateData({
        'books': FieldValue.arrayUnion([issuedBook])
      });
    } catch (e) {
      print(e);
      print('in addbook setdata');
      try {
        print(roll);
        final student = studentCollection.document(roll);
        final sData = await student.get();
        print(sData.data);
        student.updateData({
          'books': [issuedBook],
        });
      } catch (e) {
        print(e);
        print('books not available in add book');
      }
    }
  }

  void removeBookFromStudent() async {
    Map issuedBook = await getIssuedBookByIsbn(isbn);
    if (issuedBook == null) {
      print('Not your book');
      return;
    }
    final studentCollection = db.collection('student');
    await studentCollection.document(roll).updateData({
      'books': FieldValue.arrayRemove([issuedBook])
    });
  }

  void reissueBookToStudent() async {
    Map issuedBook=await getIssuedBookByIsbn(isbn);
    if(issuedBook==null){
      print('Not your book');
      return;
    }
    DateTime now=DateTime.now();
    DateTime issueNowDate = DateTime(now.year, now.month, now.day);
    DateTime reissue = DateTime(now.year, now.month, now.day + 15);
    print(issueNowDate.toString());
    String issuedDate = issueNowDate.toString();
    String returnDate = reissue.toString();
    issuedDate = getStringFromDate(issuedDate);
    returnDate = getStringFromDate(returnDate);
//    print(myDatetime.difference(mySecondDate).inDays.toString());
    print(issuedDate);
    print(returnDate);
    Map<String, String> newIssuedBook = {
      'smallThumbnail': imgUrl ?? imgIsNull,
      'isbn': isbn,
      'title': title,
      'author': author,
      'issueDate': issuedDate,
      'returnDate': returnDate,
    };
    print(newIssuedBook);
    int days=issueNowDate.difference(DateTime.parse(issuedBook['returnDate'])).inDays;
    if(days<0){
      days=0;
    }
    print(days);
    removeBookFromStudent();
    newIssuedBook['fine']=(days*2).toString();
    final studentCollection = db.collection('student');
    try {
      await studentCollection.document(roll).updateData({
        'books': FieldValue.arrayUnion([newIssuedBook])
      });
    } catch (e) {
      print(e);
      print('in reissuebook setdata');
      try {
        print(roll);
        final student = studentCollection.document(roll);
        final sData = await student.get();
        print(sData.data);
        student.updateData({
          'books': [newIssuedBook],
        });
      } catch (e) {
        print(e);
        print('books not available in reissue book');
      }
    }


  }

  @override
  Widget build(BuildContext context) {
    rollAndOp = ModalRoute.of(context).settings.arguments as List;
    print('in book issue ${rollAndOp[0]} and ${rollAndOp[1]}');
    roll = rollAndOp[0]; //very important don't forget
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                'images/back.jpeg',
                fit: BoxFit.fill,
              ),
            ),
            Scaffold(
              backgroundColor: Color(0xbbffffff),
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
                      setState(() {
                        showSpinner = true;
                      });
                      getBookByIsbn();
                      setState(() {
                        showSpinner = false;
                      });
                    },
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Visibility(
                          visible: isVisible,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: BookCard(
                              title: title,
                              isbn: isbn,
                              imgURL: imgUrl,
                              author: author,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isError,
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Text('$errorMessage',
                            textAlign: TextAlign.center,
                            style: kTitleTextStyle.copyWith(
                              fontSize: 30,
                            ),),
                              ),),
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: RoundIconButton(
                            width: double.infinity,
                            onPress: () {
                              setState(() {
                                showSpinner = true;
                              });
                              if (rollAndOp[1] == 'add') addBookToStudent();
                              if (rollAndOp[1] == 'return')
                                removeBookFromStudent();
                              if (rollAndOp[1] == 'reissue')
                                reissueBookToStudent();
                              setState(() {
                                showSpinner = false;
                              });
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return CustomDialog(
                                    title: 'Successful',
                                    message: 'Book ${rollAndOp[1]}',
                                    onPress: () {
                                      Navigator.pushNamed(
                                          context, HomeScreen.id);
                                    },
                                  );
                                },
                              );
                            },
                            title: rollAndOp[1].toUpperCase() ?? 'Add',
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
