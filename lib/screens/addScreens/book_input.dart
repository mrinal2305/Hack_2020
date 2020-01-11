import 'package:flutter/material.dart';
import 'package:librarian/services/book_model.dart';
import 'package:librarian/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class BookInput extends StatefulWidget {
  static const id = 'book_input';

  @override
  _BookInputState createState() => _BookInputState();
}

class _BookInputState extends State<BookInput> {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final ddcController = TextEditingController();

  bool showSpinner = false;
  String title;
  String author;
  String isbn;
  String ddc;
  String imgUrl;

  void getDDC() async {
    setState(() {
      showSpinner = true;
    });

    //if is added as book for null is shown if not checked
    if (title != null) {
      var bookData = await BookModel().getBookDDC(title);
      try {
        print(title);
        setState(() {
          ddc = bookData[0]['ddc'];
          ddcController.text = ddc;
          print(ddc);
        });
      } catch (e) {
        print(e);
      }
      setState(() {
        showSpinner = false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    ddcController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookData = ModalRoute.of(context).settings.arguments as Map;
    try {
      title = bookData['title'];
      author = bookData['author'];
      isbn = bookData['isbn']['isbn_10'];
      imgUrl=bookData['imageLinks']['smallThumbnail']??'http://books.google.com/books/content?id=8bbMjwEACAAJ&printsec=frontcover&img=1&zoom=5&source=gbs_api';

      titleController.value = TextEditingValue(
        text: title,
        selection: TextSelection.fromPosition(
          TextPosition(offset: title.length),
        ),
      );
//      print(title);
//      print(author);
//      print(isbn);
    } catch (e) {}
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(child: Image.network(imgUrl)),
                    Flexible(
                      child: TextFormField(
                        controller: titleController,
                        decoration: InputDecoration(
                          labelText: 'Title:',
                          alignLabelWithHint: true,
                        ),
                        validator: (input) =>
                            input.contains('') ? 'Not a valid Title' : null,
                        onChanged: (value) {
//                          title = value;
                        },
//                      onSaved: (input) => _email = input,
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
                        initialValue: author,
                        decoration: InputDecoration(
                          labelText: 'Author:',
                          alignLabelWithHint: true,
                        ),
                        validator: (input) => input.length < 8
                            ? 'You need at least 8 characters'
                            : null,
//                      onSaved: (input) => _password = input,
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
                        initialValue: isbn,
                        decoration: InputDecoration(
                          labelText: 'ISBN:',
                          alignLabelWithHint: true,
                        ),
                        validator: (input) => input.length < 8
                            ? 'You need at least 8 characters'
                            : null,
//                      onSaved: (input) => _password = input,
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
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
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: () {
                              getDDC();
                            },
                            color: Colors.yellowAccent,
                            child: Text('Get DDC'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: () {
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
        ));
  }

  void submit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
    }
  }
}
