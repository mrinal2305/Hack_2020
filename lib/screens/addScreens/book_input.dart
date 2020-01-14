import 'package:flutter/material.dart';
import 'package:librarian/models/book.dart';
import 'package:librarian/services/book_model.dart';
import 'package:librarian/constants.dart';
import 'package:librarian/services/firebase_helpers.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class BookInput extends StatefulWidget {
  static const id = 'book_input';

  @override
  _BookInputState createState() => _BookInputState();
}

class _BookInputState extends State<BookInput> {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final isbnController = TextEditingController();
  final ddcController = TextEditingController();

  bool showSpinner = false;
  Book book = Book();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

  }
  void getBookFullDetails() async {

    isbnController.text = book.isbn_10;
    titleController.text = book.title;
    ddcController.text = book.ddc1;
    setState(() {
      showSpinner = true;
    });
    print('${book.isbn_10} in getfull');
    if (book.isbn_10 != null) {
      var bookData = await BookModel().getBookCompleteDetails(book.isbn_10);
//      print(bookData);
      try {
        book.author = bookData['author'];
        book.avgRating = bookData['averageRating'];
        book.description = bookData['description'];
        book.isbn_10 = bookData['isbn']['isbn_10'];
        book.isbn_13 = bookData['isbn']['isbn_13'];
//            book.issued=

        book.pageCount = bookData['pageCount'];
        book.publisher = bookData['publisher'];
        book.title = bookData['title'];
//        print(book.title);
//            book.totalCopy=
      } catch (e) {
        print('in book full details exception in bookinput');
        print(e);
      }
    }
    getDDC();
    setState(() {
      showSpinner=false;
    });
  }

  void getDDC() async {
//    setState(() {
//      showSpinner = true;
//    });

    //if is added as book for null is shown if not checked
    if (book.title != null) {
      var bookData = await BookModel().getBookDDC(book.title);
      try {
//        print(book.title);
          try {

            book.ddc1=bookData[0]['ddc'];
            book.ddc2=bookData[1]['ddc'];
            book.lcc1=bookData[0]['lcc'];
            book.lcc2=bookData[1]['lcc'];
//          ddcController.text = book.ddc;
          } catch (e){
            print('in inner try');
            print(bookData[0]);
            print(e);
          }
          print(book.ddc1);

      } catch (e) {
        print('in ddc');
        print(e);
      }
//      setState(() {
//        showSpinner = false;
//      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    ddcController.dispose();
    isbnController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text('Book Details'),
        ),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Container(
                  child: ListView(
                    children: <Widget>[
                      Image.network(book.smallThumbnail??'http://books.google.com/books/content?id=_l-PjpBOv9gC&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api'),
                      BookField(titleController: titleController),
                      TextFormField(
                        initialValue: book.author,
                        decoration: InputDecoration(
                          labelText: 'Author:',
                          alignLabelWithHint: true,
                        ),
                        validator: (input) => input.length < 8
                            ? 'You need at least 8 characters'
                            : null,
//                      onSaved: (input) => _password = input,
                      ),
                      TextFormField(
                        initialValue: book.isbn_10,
                        decoration: InputDecoration(
                          labelText: 'ISBN:',
                          alignLabelWithHint: true,
                        ),
                        validator: (input) => input.length < 8
                            ? 'You need at least 8 characters'
                            : null,
//                      onSaved: (input) => _password = input,
                      ),
                      TextFormField(
                        controller: ddcController,
                        decoration: InputDecoration(
                          labelText: 'DDC:',
                          alignLabelWithHint: true,
                        ),
                        validator: (input) => input.length < 8
                            ? 'You need at least 8 characters'
                            : null,
//                      onSaved: (input) => _password = input,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: RaisedButton(
                              onPressed: () {
                                getBookFullDetails();
                              },
                              color: Colors.yellowAccent,
                              child: Text('Save'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: RaisedButton(
                              onPressed: () async {
//                                  DatabaseService().getBookData();
                                DatabaseService().booksStream();
                                await DatabaseService().updateBookData(book);
//                            print(bookData);
//                            print(title);
                              },
                              color: Colors.red,
                              child: Text('Add'),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  void submit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
    }
  }
}

class BookField extends StatelessWidget {
  BookField({this.titleController});

  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: titleController,
      decoration: InputDecoration(
        labelText: 'Title:',
        alignLabelWithHint: true,
      ),
      validator: (input) => input.contains('') ? 'Not a valid Title' : null,
      onChanged: (value) {
//                          title = value;
      },
//                      onSaved: (input) => _email = input,
    );
  }
}
