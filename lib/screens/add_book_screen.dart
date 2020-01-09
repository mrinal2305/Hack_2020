import 'package:flutter/material.dart';
import 'package:librarian/constants.dart';
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff3ab397),
          title: Text('Add Book'),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          child: Icon(Icons.add),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (value) {
                bookTitleField = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    var bookData =
                        await BookModel().getBookDetails(bookTitleField);
                    for (int i = 0; i < 5; i++) {
//
                    try {
                      title = bookData[i]['title'];
                      url = bookData[i]['imageLinks']['smallThumbnail'];
                    } catch(e){
                      print(e);
                      continue;
                    }
                      setState(() {
                        booksInfo.add(BookInfo(title, url));

                      });
//                      print(title);
//                      print(url);
                    }
                  },
                ),
                hintText: 'Enter book title',
              ),
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
          ),
        ],
      ),
    );
  }
}
