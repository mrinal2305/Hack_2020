import 'package:flutter/material.dart';
import 'package:librarian/models/book.dart';
import 'package:librarian/services/book_model.dart';
import 'package:librarian/constants.dart';
import 'package:librarian/services/firebase_helpers.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:librarian/elements/book_field.dart';

class BookInput extends StatefulWidget {
  static const id = 'book_input';

  @override
  _BookInputState createState() => _BookInputState();
}

class _BookInputState extends State<BookInput> {
  final formKey = GlobalKey<FormState>();
  bool toCall=true;

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
  final descriptionController = TextEditingController();
  final ratingController = TextEditingController();

  bool showSpinner = false;
  Book book = Book();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {//it get called whenever anything changes
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final bookInfoFromPeace = ModalRoute.of(context).settings.arguments as Book;
    book.smallThumbnail = bookInfoFromPeace.smallThumbnail;
    book.title = bookInfoFromPeace.title;
    book.isbn_10 = bookInfoFromPeace.isbn_10;
    if(toCall){
      toCall=false;
      getBookFullDetails();//whenever text changes it get called
    }
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
      showSpinner = false;
    });
    isbnController13.text = book.isbn_13;
    authorController.text = book.author;
    publisherController.text = book.publisher;

    pageCountController.text = book.pageCount;
    ratingController.text = book.avgRating;
    descriptionController.text = book.description;
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
          book.ddc1 = bookData[0]['ddc'];
          book.ddc2 = bookData[1]['ddc'];
          book.lcc1 = bookData[0]['lcc'];
          book.lcc2 = bookData[1]['lcc'];
          ddcController.text = book.ddc1;
          lccController.text = book.lcc1;
//          ddcController.text = book.ddc;
        } catch (e) {
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
    final data = MediaQuery.of(context).size;
    return MaterialApp(
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              title: Text('Book Details'),
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(icon: Icon(Icons.info), text: "Information"),
                  Tab(
                    icon: Icon(Icons.description),
                    text: "NLP",
                  )
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
                                  height: data.height * 0.3,
                                  child: Card(
                                    child: Image.network(book.smallThumbnail ??
                                        'http://books.google.com/books/content?id=_l-PjpBOv9gC&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api'),
                                  ),
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      child: BookField(
                                        controller: titleController,
                                        label: 'Title',
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: BookField(
                                        controller: authorController,
                                        label: 'Author',
                                      ),
                                    ),
                                    Container(
                                        width: double.infinity,
                                        child: BookField(
                                          controller: ddcController,
                                          label: 'DDC',
                                        )),
                                    Container(
                                      width: double.infinity,
                                      child: BookField(
                                        controller: isbnController10,
                                        label: 'ISBN10',
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: BookField(
                                        controller: isbnController13,
                                        label: 'ISBN13',
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: BookField(
                                        controller: pageCountController,
                                        label: 'Page Count',
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: BookField(
                                        controller: descriptionController,
                                        label: 'Description',
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ),
                ModalProgressHUD(
                  inAsyncCall: showSpinner,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          Container(),
                          Container(),
                          Container()
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  void submit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
    }
  }
}
