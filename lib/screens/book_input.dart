import 'package:flutter/material.dart';
import 'package:lbs/services/book_model.dart';
import 'package:lbs/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:lbs/elements/books.dart';
import 'package:lbs/providers/saved_books.dart';
import 'package:provider/provider.dart';
import 'package:lbs/screens/saved_books/personal_book_screen.dart';






class BookInput extends StatefulWidget {
  static const id = 'book_input';
  @override
  _BookInputState createState() => _BookInputState();
}

class _BookInputState extends State<BookInput> {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();


  bool showSpinner = false;
  String title;
  String author;
  String isbn;
  String description;
  String imgUrl;

  void getDDC() async {
    setState(() {
      showSpinner = true;
    });


    //if is added as book for null is shown if not checked
    if (isbn != null) {
      print(isbn);
      var bookData = await BookModel().getBookDescription(isbn);
      try {
        print(title);
        setState(() {
          description = bookData['description'];
          descriptionController.text = description;
          print(description);
        });
      } catch (e) {
        print(e);
      }
      setState(() {
        showSpinner = false;
      });
    }
  }
  //Function to pass the gathered information about the book to the book list screen
  void saveBook(){
    Books books=Books(imgUrl: imgUrl,isbn: isbn,description: description,title: title,author: author);
    Provider.of<SavedBooks>(context, listen :false).addBook(books);
    Navigator.pushNamed(context, BookListScreen.id);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookData = ModalRoute.of(context).settings.arguments as Map;
    try {
      title = bookData['title'];
      author = bookData['author'];
      isbn = bookData['isbn']['isbn_10'];

      try{
      imgUrl=bookData['imageLinks']['smallThumbnail'];}
      catch(e){
        print(imgUrl);
        imgUrl=bookData['image']['smallThumbnail'];
      }
      print(imgUrl);
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
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text('Book Details'),
        ),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
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
                        child: Card(

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
                          controller: descriptionController,
                          decoration: InputDecoration(
                            labelText: 'Description:',
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
//                            print(bookData);
//                            print(title);
                                getDDC();
                                print(description);
                                //onAdd();
                              },
                              color: Colors.red,
                              child: Text('Description'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: RaisedButton(
                              onPressed: () {
                                   saveBook();
                              },
                              color: Colors.red,
                              child: Text('Add'),
                            ),
                          )
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

