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
  final isbnController10 = TextEditingController();
  final ddcController = TextEditingController();
  final authorController = TextEditingController();
  final lccController = TextEditingController();
  //final lcc2Controller = TextEditingController();
//  final ddc1Controller = TextEditingController();
//  final ddc2Controller = TextEditingController();
  final publisherController = TextEditingController();
  final pageCountController = TextEditingController();
  final isbnController13 = TextEditingController();
  final descriptionController =TextEditingController();
  final ratingController =TextEditingController();



//  String lcc1='lcc1';
//  String lcc2='lcc2';
//  String pageCount='234';
//  String publisher='wiley';
//  String smallThumbnail='small';
//  String thumbnail='thumb';
//  String title='title';


  bool showSpinner = false;
  Book book = Book();
  bool toCall =true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final bookInfoFromPeace = ModalRoute.of(context).settings.arguments as Book;
    book.smallThumbnail=bookInfoFromPeace.smallThumbnail;
    book.title=bookInfoFromPeace.title;
    book.isbn_10=bookInfoFromPeace.isbn_10;
    if(toCall){
      toCall=false;
    getBookFullDetails();}


  }

    //Function to pass the gathered information about the book to the book list screen
  void saveBook(){
    Book books=Book(smallThumbnail: book.smallThumbnail,isbn_10: book.isbn_10,description: book.description,title: book.title,author: book.author);
    Provider.of<SavedBooks>(context, listen :false).addBook(books);
    Navigator.pushNamed(context, BookListScreen.id);
  }
  void getBookFullDetails() async {

    isbnController10.text = book.isbn_10;
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
        print(book.avgRating);
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
    isbnController13.text=book.isbn_13;
    authorController.text=book.author;
    publisherController.text=book.publisher;

    pageCountController.text=book.pageCount;
    ratingController.text=book.avgRating;
    descriptionController.text=book.description;
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
          ddcController.text=book.ddc1;
          lccController.text=book.lcc1;
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
    isbnController10.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data=MediaQuery.of(context).size;
    return MaterialApp(
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              title: Text('Book Details'),
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(icon: Icon(Icons.info),text:"Information"),
                  Tab(icon: Icon(Icons.description),text: "description",)
                ],
              ),


            ),
            body: TabBarView(
              children: <Widget>[
                ModalProgressHUD(
                  inAsyncCall: showSpinner,
                  child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Card(
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: <Widget>[
                              Center(
                                child: Container(
                                  height: data.height*0.3,
                                  child: Card(
                                    child: Image.network(book.smallThumbnail??'http://books.google.com/books/content?id=_l-PjpBOv9gC&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api'),

                                  ),

                                ),
                              ),
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      child: BookFieldTitle(titleController: titleController,),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: BookFieldAuthor(authorController: authorController,),
                                    ),
                                    Container(
                                        width: double.infinity,
                                        child: BookFieldDdc(ddcController: ddcController,)
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: BookFieldIsbn10(isbn10Controller: isbnController10,),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: BookFieldIsbn13(isbn13Controller: isbnController13,),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: BookFieldPageCount(pageCountController: pageCountController,),
                                    ),
//                                    Container(
//                                      width:double.infinity,
//                                      child: BookFieldDescription(descriptionController: descriptionController,),
//                                    )

                                  ],
                                ),
                              )
//for images title author pages
                            ],
                          ),
                        ),)




                  ),
                ),
                ModalProgressHUD(
                  inAsyncCall: showSpinner,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Card(
                      child: Container(
                        width:double.infinity,
                        child: BookFieldDescription(descriptionController: descriptionController,),
                      ),

                    ),
                  ),
                )

              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                saveBook();
              },
            ),

          )
      ),
    );

  }

  void submit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
    }
  }
}

class BookFieldTitle extends StatelessWidget {

  BookFieldTitle({this.titleController});

  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: titleController,
      keyboardType: TextInputType.multiline,
      maxLines: null,
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


class BookFieldAuthor extends StatelessWidget {

  BookFieldAuthor({this.authorController});

  final TextEditingController authorController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: authorController,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
        labelText: 'Author:',
        alignLabelWithHint: true,
      ),
      validator: (input) => input.contains('') ? 'Not a valid Author' : null,
      onChanged: (value) {
//                          title = value;
      },
//                      onSaved: (input) => _email = input,
    );

  }
}

class BookFieldIsbn10 extends StatelessWidget {
  BookFieldIsbn10({this.isbn10Controller});

  final TextEditingController isbn10Controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: isbn10Controller,
      decoration: InputDecoration(
        labelText: 'Isbn 10:',
        alignLabelWithHint: true,
      ),
      validator: (input) => input.length < 10
          ? 'You need at least 10 characters'
          : null,
      onChanged: (value) {
//                          title = value;
      },
//                      onSaved: (input) => _email = input,
    );
  }
}

class BookFieldIsbn13 extends StatelessWidget {
  BookFieldIsbn13({this.isbn13Controller});

  final TextEditingController isbn13Controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: isbn13Controller,
      decoration: InputDecoration(
        labelText: 'Isbn 13:',
        alignLabelWithHint: true,
      ),
      validator: (input) => input.length < 13
          ? 'You need at least 13 characters'
          : null,
      onChanged: (value) {
//                          title = value;
      },
//                      onSaved: (input) => _email = input,
    );
  }
}

class BookFieldPublisher extends StatelessWidget {
  BookFieldPublisher({this.publisherController});

  final TextEditingController publisherController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: publisherController,
      decoration: InputDecoration(
        labelText: 'Publisher:',
        alignLabelWithHint: true,
      ),
      validator: (input) => input.contains('') ? 'Not a valid Publisher' : null,
      onChanged: (value) {
//                          title = value;
      },
//                      onSaved: (input) => _email = input,
    );
  }
}

class BookFieldDescription extends StatelessWidget {
  BookFieldDescription({this.descriptionController});

  final TextEditingController descriptionController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: descriptionController,
      decoration: InputDecoration(
        labelText: 'Description :',
        alignLabelWithHint: true,
      ),
      validator: (input) => input.contains('') ? 'Not a valid Description' : null,
      onChanged: (value) {
//                          title = value;
      },
//                      onSaved: (input) => _email = input,
    );
  }
}

class BookFieldPageCount extends StatelessWidget {
  BookFieldPageCount({this.pageCountController});

  final TextEditingController pageCountController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: pageCountController,
      decoration: InputDecoration(
        labelText: 'Pages :',
        alignLabelWithHint: true,
      ),
      validator: (input) => input.contains('') ? 'Page numbers not valid' : null,
      onChanged: (value) {
//                          title = value;
      },
//                      onSaved: (input) => _email = input,
    );
  }
}

class BookFieldAverageRating extends StatelessWidget {
  BookFieldAverageRating({this.ratingController});

  final TextEditingController ratingController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: ratingController,
      decoration: InputDecoration(
        labelText: 'Ratings :',
        alignLabelWithHint: true,
      ),
      validator: (input) => input.contains('') ? 'Ratings is not valid' : null,
      onChanged: (value) {
//                          title = value;
      },
//                      onSaved: (input) => _email = input,
    );
  }
}

class BookFieldDdc extends StatelessWidget {
  BookFieldDdc({this.ddcController});

  final TextEditingController ddcController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: ddcController,
      decoration: InputDecoration(
        labelText: 'Ddc :',
        alignLabelWithHint: true,
      ),
      validator: (input) => input.contains('') ? 'Ddc is not valid' : null,
      onChanged: (value) {
//                          title = value;
      },
//                      onSaved: (input) => _email = input,
    );
  }
}


class BookFieldLcc extends StatelessWidget {
  BookFieldLcc({this.lccController});

  final TextEditingController lccController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: lccController,
      decoration: InputDecoration(
        labelText: 'Lcc :',
        alignLabelWithHint: true,
      ),
      validator: (input) => input.contains('') ? 'Lcc is not valid' : null,
      onChanged: (value) {
//                          title = value;
      },
//                      onSaved: (input) => _email = input,
    );
  }
}







//class _BookInputState extends State<BookInput> {
//  final formKey = GlobalKey<FormState>();
//
//  final titleController = TextEditingController();
//  final descriptionController = TextEditingController();
//
//
//  bool showSpinner = false;
//  String title;
//  String author;
//  String isbn;
//  String description;
//  String imgUrl;
//
//  void getDDC() async {
//    setState(() {
//      showSpinner = true;
//    });
//
//
//    //if is added as book for null is shown if not checked
//    if (isbn != null) {
//      print(isbn);
//      var bookData = await BookModel().getBookDescription(isbn);
//      try {
//        print(title);
//        setState(() {
//          description = bookData['description'];
//          descriptionController.text = description;
//          print(description);
//        });
//      } catch (e) {
//        print(e);
//      }
//      setState(() {
//        showSpinner = false;
//      });
//    }
//  }
//  //Function to pass the gathered information about the book to the book list screen
//  void saveBook(){
//    Books books=Books(imgUrl: imgUrl,isbn: isbn,description: description,title: title,author: author);
//    Provider.of<SavedBooks>(context, listen :false).addBook(books);
//    Navigator.pushNamed(context, BookListScreen.id);
//  }
//
//  @override
//  void dispose() {
//    // TODO: implement dispose
//    super.dispose();
//    titleController.dispose();
//    descriptionController.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    final bookData = ModalRoute.of(context).settings.arguments as Map;
//    try {
//      title = bookData['title'];
//      author = bookData['author'];
//      isbn = bookData['isbn']['isbn_10'];
//
//      try{
//      imgUrl=bookData['imageLinks']['smallThumbnail'];}
//      catch(e){
//        print(imgUrl);
//        imgUrl=bookData['image']['smallThumbnail'];
//      }
//      print(imgUrl);
//      titleController.value = TextEditingValue(
//        text: title,
//        selection: TextSelection.fromPosition(
//          TextPosition(offset: title.length),
//        ),
//      );
////      print(title);
////      print(author);
////      print(isbn);
//    } catch (e) {}
//    return  Scaffold(
//        appBar: AppBar(
//          backgroundColor: kPrimaryColor,
//          title: Text('Book Details'),
//        ),
//        body: ModalProgressHUD(
//          inAsyncCall: showSpinner,
//          child: SingleChildScrollView(
//            physics: BouncingScrollPhysics(),
//            child: Card(
//              child: Form(
//                key: formKey,
//                child: Column(
//                    children: <Widget>[
//                      Container(
//                        color: Color(0xff00BFA5),
//                        child: Row(
//                          children: <Widget>[
//                            Column(
//                              children: <Widget>[
//                                Card(
//                                  elevation:8.0,
//                                  child: Image.network(imgUrl),
//                                ),
//                                Container(
//                                  width:100,
//                                  child: Card(
//                                      color: Color(0xFF00897B),
//                                      child: TextFormField(
//                                        initialValue: '280',
//                                        keyboardType: TextInputType.multiline,
//                                        maxLines: null,
//                                        //controller: titleController,
//                                        decoration: InputDecoration(
//                                          labelText: 'Pages:',
//                                          labelStyle: TextStyle(
//                                              color: Colors.white
//                                          ),
//                                          alignLabelWithHint: true,
//                                        ),
//                                        validator: (input) =>
//                                        input.contains('') ? 'Not a valid Title' : null,
//                                        onChanged: (value) {
//                                          //title = value;
//                                        },
//                                        //                      onSaved: (input) => _email = input,
//                                      )
//
//                                  ),
//                                ),
//                                Row(
//                                  children: <Widget>[
//                                    Text('Ratings '),
//                                    Icon(
//                                      Icons.star,
//                                      color: Color(0xffffd700),
//                                    )
//                                  ],
//                                )
//                              ],
//                            ),
//                            Column(
//                              children: <Widget>[
//                                 Container(
//
//                                   width: 200,//TODO :change it to media query
//                                   child: Card(
//                                     color: Color(0xFF00897B),
//                                     child: TextFormField(
//                                       keyboardType: TextInputType.multiline,
//                                      maxLines: null,
//                               controller: titleController,
//                              decoration: InputDecoration(
//                             labelText: 'Title:',
//                             labelStyle: TextStyle(
//                               color: Colors.white
//                             ),
//                             alignLabelWithHint: true,
//                               ),
//                             validator: (input) =>
//                             input.contains('') ? 'Not a valid Title' : null,
//                             onChanged: (value) {
//                             title = value;
//                           },
//                           //                      onSaved: (input) => _email = input,
//                            ),
//                                   ),
//                                 ),
//                                Container(
//                                  width: 200,//TODO :change it to media query
//                                  child: Card(
//                                    color: Color(0xFF00897B),
//                                    child: TextFormField(
//                                      keyboardType: TextInputType.multiline,
//                                      maxLines: null,
//                                    initialValue: author,
//                                    decoration: InputDecoration(
//                                     labelText: 'Author:',
//                                    labelStyle: TextStyle(
//                                      color: Colors.white
//                                    ),
//                                    alignLabelWithHint: true,
//                                    ),
//                                    validator: (input) => input.length < 8
//                                    ? 'You need at least 8 characters'
//                                       : null,
//                                //                      onSaved: (input) => _password = input,
//                                ),
//                                  )
//
//
//                                ),
//                               Container(
//                                 width:200,
//                                 child:Card(
//                                   color: Color(0xFF00897B),
//                                   child: TextFormField(
//                                  initialValue: isbn,
//                                  decoration: InputDecoration(
//                                  labelText: 'ISBN 10:',
//                                  labelStyle: TextStyle(
//                                    color: Colors.white
//                                  ),
//                                  alignLabelWithHint: true,
//                                  ),
//                                  validator: (input) => input.length < 8
//                                  ? 'You need at least 8 characters'
//                                      : null,
//                                 //                      onSaved: (input) => _password = input,
//                                  ),
//
//                                 )
//                               ),
//                                Container(
//                                    width:200,
//                                    child:Card(
//                                      color: Color(0xFF00897B),
//                                      child: TextFormField(
//                                        initialValue: isbn,
//                                        decoration: InputDecoration(
//                                          labelText: 'ISBN 13:',
//                                          labelStyle: TextStyle(
//                                              color: Colors.white
//                                          ),
//                                          alignLabelWithHint: true,
//                                        ),
//                                        validator: (input) => input.length < 8
//                                            ? 'You need at least 8 characters'
//                                            : null,
//                                        //                      onSaved: (input) => _password = input,
//                                      ),
//
//                                    )
//                                )
//                              ],
//                            )
//                          ],
//
//                        ),
//                      ),
//                      SingleChildScrollView(
//                        child: Container(
//                          width: double.infinity,
//                          child: TextFormField(
//                                keyboardType: TextInputType.multiline,
//                                maxLines: null,
//                                controller: descriptionController,
//                               decoration: InputDecoration(
//                              labelText: 'Description:',
//                               alignLabelWithHint: true,
//                                ),
//                                validator: (input) => input.length < 8
//                              ? 'You need at least 8 characters'
//                                  : null,
//                            //                      onSaved: (input) => _password = input,
//                            ),
//                        ),
//                      )
//                    ],
//                  ),
//              ),
//            ),
//          ),
//        ),
//        floatingActionButton: FloatingActionButton(
//        onPressed: (){
//          getDDC();
//        },
//          child: Icon(
//            Icons.add
//          ),
//    ),
//    );
//  }
//
//  void submit() {
//    if (formKey.currentState.validate()) {
//      formKey.currentState.save();
//    }
//  }
//}




//children: <Widget>[
//Flexible(child: Image.network(imgUrl)),
//Flexible(
//child: Card(
//
//child: TextFormField(
//controller: titleController,
//decoration: InputDecoration(
//labelText: 'Title:',
//alignLabelWithHint: true,
//),
//validator: (input) =>
//input.contains('') ? 'Not a valid Title' : null,
//onChanged: (value) {
////                          title = value;
//},
////                      onSaved: (input) => _email = input,
//),
//),
//),
//Flexible(
//child: TextFormField(
//initialValue: author,
//decoration: InputDecoration(
//labelText: 'Author:',
//alignLabelWithHint: true,
//),
//validator: (input) => input.length < 8
//? 'You need at least 8 characters'
//    : null,
////                      onSaved: (input) => _password = input,
//),
//),
//Flexible(
//child: TextFormField(
//initialValue: isbn,
//decoration: InputDecoration(
//labelText: 'ISBN:',
//alignLabelWithHint: true,
//),
//validator: (input) => input.length < 8
//? 'You need at least 8 characters'
//    : null,
////                      onSaved: (input) => _password = input,
//),
//),
//Flexible(
//child: Wrap(
//children: <Widget>[
//TextFormField(
//keyboardType: TextInputType.multiline,
//maxLines: null,
//controller: descriptionController,
//decoration: InputDecoration(
//labelText: 'Description:',
//alignLabelWithHint: true,
//),
//validator: (input) => input.length < 8
//? 'You need at least 8 characters'
//    : null,
////                      onSaved: (input) => _password = input,
//),
//]
//)),
//Row(
//mainAxisAlignment: MainAxisAlignment.end,
//children: <Widget>[
//
//Padding(
//padding: EdgeInsets.all(8.0),
//child: RaisedButton(
//onPressed: () {
////                            print(bookData);
////                            print(title);
//getDDC();
//print(description);
////onAdd();
//},
//color: Colors.red,
//child: Text('Description'),
//),
//),
//Padding(
//padding: EdgeInsets.all(8.0),
//child: RaisedButton(
//onPressed: () {
//saveBook();
//},
//color: Colors.red,
//child: Text('Add'),
//),
//)
//],
//)
//],
