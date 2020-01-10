import 'package:flutter/material.dart';
import 'package:librarian/elements/custom_speed_dial.dart';
import 'package:librarian/services/book_model.dart';

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
  String bookTitleField;
  String url =
      'http://books.google.com/books/content?id=8bbMjwEACAAJ&printsec=frontcover&img=1&zoom=5&source=gbs_api';
  String title = 'hello';

  List<BookInfo> booksInfo = [];

  void getBooksByTitle(String bookTitle) async {
    setState(() {
      booksInfo = [];
    });

    //if is added as book for null is shown if not checked
    if (bookTitle != null) {
//      bookTitleField = onValue;
      var bookData = await BookModel().getBookDetailsByTitle(bookTitle);
      for (int i = 0; i < 5; i++) {
        try {
          //
          print(i);
          title = bookData[i]['title'];
          url = bookData[i]['imageLinks']['smallThumbnail'];
          print(title);
          print(url);
        } catch (e) {
          print(e);
          continue;
        }
        setState(() {
          booksInfo.add(BookInfo(title, url));
        });
      }
    }
  }

  void getBooksByIsbn(String bookISBN) async {
    setState(() {
      booksInfo = [];
    });

    //if is added as book for null is shown if not checked
    if (bookISBN != null) {
      var bookData = await BookModel().getBookDetailsByISBN(bookISBN);
      try {
        title = bookData['title']['_text'];
        if (title == null) {
          title = bookData['title']['_cdata'];
          if (title == null) title = 'hello';
        }
        url = bookData['image']['smallThumbnails']['_text'];
        print(title);
        print(url);
      } catch (e) {
        print('in outer try');
        print(e);
      }
      setState(() {
        booksInfo.add(BookInfo(title, url));
      });
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
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return BookCard(
                    bookTitle: booksInfo[index].bookName,
                    imgURL: booksInfo[index].bookURL,
                  );
                },
                itemCount: booksInfo.length,
              ),
            ),
          ],
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
