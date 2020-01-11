import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:librarian/elements/custom_speed_dial.dart';
import 'package:librarian/screens/addScreens/book_input.dart';
import 'package:librarian/services/book_model.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class BookInfo {
  String bookName;
  String bookURL;

  BookInfo(this.bookName, this.bookURL);
}

class AddBookScreen extends StatefulWidget {
  static const id = 'add_book_screen';

  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  var bookData;//added for taking json data
  String bookTitleField;
  String imgUrl =
      'http://books.google.com/books/content?id=8bbMjwEACAAJ&printsec=frontcover&img=1&zoom=5&source=gbs_api';
  String title = 'hello';
  bool showSpinner = false; //used to check whether to show spinner or not

  List<BookInfo> booksInfo = [];

  void getBooksByTitle(String bookTitle) async {
    setState(() {
      showSpinner = true;
      booksInfo = [];
    });

    //if is added as book for null is shown if not checked
    if (bookTitle != null) {
//      bookTitleField = onValue;
       bookData = await BookModel().getBookDetailsByTitle(bookTitle);
      for (int i = 0; i < 5; i++) {
        try {
          //
//          print(i);
          title = bookData[i]['title'];
          imgUrl = bookData[i]['imageLinks']['smallThumbnail'];
//          print(title);
//          print(url);
        } catch (e) {
          print(e);
          continue;
        }
        setState(() {
          showSpinner = false;
          booksInfo.add(BookInfo(title, imgUrl));
        });
      }
    }
  }

  void getBooksByIsbn(String bookISBN) async {
    setState(() {
      showSpinner = true;
      booksInfo = [];
    });

    //if is added as book for null is shown if not checked
    if (bookISBN != null) {
       bookData = await BookModel().getBookDetailsByISBN(bookISBN);
      try {
        title = bookData['title'];
        imgUrl = bookData['image']['smallThumbnail'];
//        print(title);
//        print(url);
      } catch (e) {
        print('in outer try');
        print(e);
      }
      setState(() {
        showSpinner = false;
        booksInfo.add(BookInfo(title, imgUrl));
      });
    }
  }

  void getBookByBar() async{
      try{
        String result=await BarcodeScanner.scan();
        print(result);
        getBooksByIsbn(result);
      } on PlatformException catch(e){
        if(e.code==BarcodeScanner.CameraAccessDenied){
          print('camera acces denied');
        } else {
          print(e);
        }
      } on FormatException{
        print('You pressed the back button before scanning anything');
      } catch (e){
        print(e);
      }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff3ab397),
          title: Text('Add Book'),
        ),
        floatingActionButton: CustomSpeedDial(
          onISBNPressed: (value) {
            getBooksByIsbn(value);
          },
          onTitlePressed: (value) {
            getBooksByTitle(value);
          },
          onBarPressed: (){
            getBookByBar();
          },
        ),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
//                        print(index);
//                        print(bookData[index]);
                        Navigator.pushNamed(context, BookInput.id,arguments: bookData[index]);
                      },
                      child: BookCard(
                        bookTitle: booksInfo[index].bookName,
                        imgURL: booksInfo[index].bookURL,
                      ),
                    );
                  },
                  itemCount: booksInfo.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final imgURL;
  final bookTitle;

  BookCard({this.bookTitle, this.imgURL});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
//      width: 200,
      child: Column(
        children: <Widget>[
          Flexible(
            child: Image(
              image: NetworkImage(imgURL),
            ),
          ),
          Text(
            bookTitle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
