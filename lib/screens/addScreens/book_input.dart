import 'package:flutter/material.dart';
import 'package:librarian/constants.dart';

class BookInput extends StatelessWidget {
  static const id = 'book_input';

  final formKey = GlobalKey<FormState>();
  String title;
  String author;
  String isbn;
  String ddc;

  @override
  Widget build(BuildContext context) {
    final  bookData = ModalRoute.of(context).settings.arguments as Map;
    try{
      title=bookData['title'];
      author=bookData['author'][0];
      isbn=bookData['isbn'][1]['identifier'];
      print(title);
      print(author);
      print(isbn);
    } catch(e){

    }
    return new Scaffold(
        appBar: AppBar(
          title: Text('Book Details'),
        ),
        body: Card(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(child: Image.asset('images/collaboration.png')),
                  Flexible(
                    child: TextFormField(
                      initialValue: 'hello' ,
                      decoration: InputDecoration(
                        labelText: 'Title:',
                        alignLabelWithHint: true,
                      ),
                      validator: (input) =>
                          input.contains('') ? 'Not a valid Title' : null,
//                      onSaved: (input) => _email = input,
                    ),
                  ),
                  Flexible(
                    child: TextFormField(
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
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          onPressed: (){
//                            print(bookData);
                            print(title);
                          },
                          color: Colors.red,
                          child: Text('ADD'),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void _submit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
    }
  }
}
