import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lbs/elements/custom_speed_dial.dart';
import 'package:lbs/screens/book_input.dart';
import 'package:lbs/services/book_model.dart';
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
    final data=MediaQuery.of(context);
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
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
//                        print(index);
//                        print(bookData[index]);
                        Navigator.pushNamed(context, BookInput.id,arguments: bookData[index]??bookData);
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
    return Column(
      children:<Widget>[
      Container(
      //height: 100,
//      width: 200,
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Column(
//              child: Image(
//                image: NetworkImage(imgURL),
//              ),

                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24.0),
                    child: Card(
                      elevation:5.0,
                      child: Image(
                        image: NetworkImage(imgURL),


                      ),
                    ),
                  ),



                ],
              ),
            ),
          ),
          Flexible(
            flex: 6,
            child: Text(
              bookTitle,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontFamily: ('Nunito'),
                  fontWeight: FontWeight.w700,
                  fontSize: 18.0
              ),
            ),
          ),
        ],
      ),
    )
      ,
        Divider(
          color: Colors.grey.withOpacity(0.5),
          height: 20.0,
          indent: 20.0,
          endIndent: 20.0,

        )
      ]

       );
  }
}