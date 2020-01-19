import 'package:flutter/material.dart';
import 'package:librarian/elements/round_icon_button.dart';
import 'package:librarian/models/book.dart';
import 'package:librarian/screens/addScreens/add_book_screen.dart';
import 'package:librarian/screens/home_screen.dart';
import 'package:librarian/services/book_model.dart';
import 'package:librarian/constants.dart';
import 'package:librarian/services/firebase_helpers.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:librarian/elements/book_field.dart';
import 'package:librarian/elements/custom_dialog.dart';
import 'package:librarian/models/nlp.dart';

class BookInput extends StatefulWidget {
  static const id = 'book_input';

  @override
  _BookInputState createState() => _BookInputState();
}

class _BookInputState extends State<BookInput>
    with SingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  bool toCall = true;

//  TabController tabController;

  final titleController = TextEditingController();
  final isbnController10 = TextEditingController();
  final ddc1Controller = TextEditingController();
  final ddc2Controller = TextEditingController();
  final authorController = TextEditingController();
  final lcc1Controller = TextEditingController();
  final lcc2Controller = TextEditingController();
  final publisherController = TextEditingController();
  final pageCountController = TextEditingController();
  final isbnController13 = TextEditingController();
  final descriptionController = TextEditingController();
  final ratingController = TextEditingController();

  bool showSpinner = false;
  Book book = Book();
  Nlp nlp = Nlp();
  List<String> category = ['a', 'b', 'c'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //it get called whenever anything changes
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final bookInfoFromPeace = ModalRoute.of(context).settings.arguments as Book;
    book.smallThumbnail = bookInfoFromPeace.smallThumbnail;
    book.title = bookInfoFromPeace.title;
    book.isbn_10 = bookInfoFromPeace.isbn_10;
    book.isbn_13 = bookInfoFromPeace.isbn_13;
//    book.isbn_13=bookInfoFromPeace.isbn_13;
    if (toCall) {
      toCall = false;
      getBookFullDetails(); //whenever text changes it get called
//      getSubCategoryDetails();
    }
  }

  //for nlp
  void getSubCategoryDetails() async {
    print(book.description);
    var bookData = await BookModel().getBookSubCategory(book.description);
    print('insubcategory');
    print(bookData);

    for (int i = 0; i < bookData['subCategory'].length; i++) {
      setState(() {
        nlp.subCategory.add({
          'score': bookData['subCategory'][i]['score'].toString(),
          'label': bookData['subCategory'][i]['label']
        });
      });
    }
  }

  void getConceptDetails() async {
    print(book.description);
    var bookData = await BookModel().getBookConcept(book.description);
    print('inConcept');
    print(bookData);

    for (int i = 0; i < bookData['concept'].length; i++) {
      setState(() {
        nlp.concept.add({
          'text': bookData['concept'][i]['text'],
          'relevance': bookData['concept'][i]['relevance'].toString()
        });
      });
    }
  }

  void getBookFullDetails() async {
    isbnController10.text = book.isbn_10;
    nlp.isbn13 = book.isbn_13; //for nlp
    titleController.text = book.title;
    ddc1Controller.text = book.ddc1;
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
//        book.isbn_13 = bookData['isbn']['isbn_13'];
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
    print('bookdesc     ${book.description}');
    getSubCategoryDetails();
    getConceptDetails();
    getCategory();
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
      print(bookData);
        try {
          book.ddc1 = bookData[0]['ddc'];
          book.ddc2 = bookData[1]['ddc'];
          book.lcc1 = bookData[0]['lcc'];
          book.lcc2 = bookData[1]['lcc'];
          ddc1Controller.text = book.ddc1;
          ddc2Controller.text = book.ddc2;
          lcc2Controller.text = book.lcc2;
          lcc1Controller.text = book.lcc1;
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

  void getCategory() async {
    if (book.title != null) {
      var bookData = await BookModel().getBookCategory(book.title);
      try {
        category[0] = (bookData['message']);
        category[1] = (bookData['categories'][0]);
        category[2] = (bookData['categories'][1]);
      } catch (e) {
        print('in category');
        print(e);
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    ddc1Controller.dispose();
    isbnController10.dispose();
    isbnController13.dispose();
    publisherController.dispose();
    authorController.dispose();
    descriptionController.dispose();
    pageCountController.dispose();
    ratingController.dispose();
    ddc1Controller.dispose();
    ddc2Controller.dispose();
    lcc1Controller.dispose();
    lcc2Controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context).size;
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              title: Text('Book Details'),
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(text: "Information"),
                  Tab(
                    text: "NLP",
                  )
                ],
              ),
            ),
            body: TabBarView(children: <Widget>[
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
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
//                                        width: double.infinity,
                                          child: BookField(
                                        controller: ddc1Controller,
                                        label: 'DDC1',
                                      )),
                                    ),
                                    Expanded(
                                      child: Container(
//                                        width: double.infinity,
                                        child: BookField(
                                          controller: ddc2Controller,
                                          label: 'DDC2',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
//                                        width: double.infinity,
                                          child: BookField(
                                        controller: lcc1Controller,
                                        label: 'LCC1',
                                      )),
                                    ),
                                    Expanded(
                                      child: Container(
//                                        width: double.infinity,
                                        child: BookField(
                                          controller: lcc2Controller,
                                          label: 'LCC2',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
                                  height: 150,
                                  child: SingleChildScrollView(
                                    child: BookField(
                                      controller: descriptionController,
                                      label: 'Description',
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 100,
                                  padding: EdgeInsets.all(8),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          'Categories',
                                          style: kTitleTextStyle,
                                        ),
                                        Text('${category[0]}'),
                                        Text('${category[1]}'),
                                        Text('${category[2]}'),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RoundIconButton(
                            width: 150.0,
                            height: 40.0,
                            title: 'ADD This Info',
                            onPress: () async {
                              setState(() {
                                showSpinner = true;
                              });
                              await DatabaseService().updateBookData(book);
                              setState(() {
                                showSpinner = false;
                              });
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return CustomDialog(
                                    title: 'Successful',
                                    message: 'Book Added',
                                    onPress: () {
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ModalProgressHUD(
                inAsyncCall: showSpinner,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        itemCount: nlp.subCategory.length,
                        itemBuilder: (context, index) {
                          return NlpCard(
                            title: 'Sub Category',
                            score: nlp.subCategory.isEmpty
                                ? 'empty'
                                : nlp.subCategory[index]['score'],
                            label: nlp.subCategory.isEmpty
                                ? 'empty'
                                : nlp.subCategory[index]['label'],
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: nlp.concept.length,
                        itemBuilder: (context, index) {
                          return NlpCard(
                            title: 'Concept',
                            score: nlp.concept.isEmpty
                                ? 'empty'
                                : nlp.concept[index]['text'],
                            label: nlp.concept.isEmpty
                                ? 'empty'
                                : nlp.concept[index]['relevance'],
                          );
                        },
                      ),
                    ),
                    RoundIconButton(
                      title: 'Add this Info',
                      width: 150.0,
                      height: 40.0,
                      onPress: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        await DatabaseService().updateNlpData(nlp);
                        setState(() {
                          showSpinner = false;
                        });
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CustomDialog(
                              title: 'Successful',
                              message: 'Nlp info Added',
                              onPress: () {
                                Navigator.pushNamed(context, HomeScreen.id);
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ])),
      ),
    );
  }

  void submit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
    }
  }
}

class NlpCard extends StatelessWidget {
  final String title;
  final String score;
  final String label;

  NlpCard({this.title, this.score, this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
//          Padding(
//            padding: const EdgeInsets.all(8.0),
//            child: Container(
//              width: MediaQuery.of(context).size.width,
//              height: 150,
//              decoration: BoxDecoration(
//                  image: DecorationImage(
//                    fit: BoxFit.fill,
//                    image: NetworkImage(
//                        'https://images.unsplash.com/photo-1523726491678-bf852e717f6a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80'),
//                  )),
//            ),
//          ),
          ExpansionTile(
            title: Text(title),
            children: <Widget>[
              Text(
                'Score : $score',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.0),
                textAlign: TextAlign.start,
              ),
              Text(
                'Label : $label',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.0),
                textAlign: TextAlign.start,
              ),
//              Text(
//                'dbpdeia_resource : jhsdjhdsjhjdkshkjsd',
//                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.0),
//                textAlign: TextAlign.start,
//              ),
            ],
          ),
        ],
      ),
    );
  }
}
