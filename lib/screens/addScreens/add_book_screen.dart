import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:librarian/constants.dart';
import 'package:librarian/elements/custom_speed_dial.dart';
import 'package:librarian/screens/addScreens/book_input.dart';
import 'package:librarian/screens/home_screen.dart';
import 'package:librarian/services/book_model.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:librarian/models/book.dart';
import 'package:librarian/elements/custom_cards.dart';
import 'package:speech_recognition/speech_recognition.dart';

class AddBookScreen extends StatefulWidget {
  static const id = 'add_book_screen';

  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  var bookData; //added for taking json data
//  String bookTitleField;
  String imgUrl =
      'http://books.google.com/books/content?id=8bbMjwEACAAJ&printsec=frontcover&img=1&zoom=5&source=gbs_api';
  String title = 'hello';
  String author;
  String isbn;
  bool showSpinner = false; //used to check whether to show spinner or not

  List<Book> booksInfo = [];

  String voiceTitle;
  SpeechRecognition speechRecognition;
  bool isAvailable = false;
  bool isListening = false;
  TextEditingController dialogController = TextEditingController();
  String resultText = "";

  @override
  void initState() {
    super.initState();
    initSpeechRecognizer();
  }

  void initSpeechRecognizer() {
    speechRecognition = SpeechRecognition();

    speechRecognition.setAvailabilityHandler(
      (bool result) {
        setState(() {
          return isAvailable = result;
        });
      },
    );

    speechRecognition.setRecognitionStartedHandler(
      () {
        setState(() {
          return isListening = true;
        });
      },
    );

    speechRecognition.setRecognitionResultHandler(
      (String speech) {
        setState(() {
          resultText = speech;
        });
        dialogController.text = resultText;
        return resultText;
      },
    );

    speechRecognition.setRecognitionCompleteHandler(
      () {
        setState(() {
          return isListening = false;
        });
      },
    );

    speechRecognition.activate().then(
      (result) {
        setState(() {
          return isAvailable = result;
        });
      },
    );
  }




  Future<String> getBookByVoice(
      BuildContext context, String heading, InputDecoration deco) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.tealAccent,
          title: Text(heading),
          content: TextField(
            decoration: deco.copyWith(
                suffixIcon: IconButton(
              icon: Icon(
                Icons.keyboard_voice,
                color: Colors.black,
              ),
              onPressed: () {
                if (isAvailable && !isListening)
                  speechRecognition.listen(locale: "en_US").then((result) {
                    print('in pink $result');
                  });
              },
            )),
            controller: dialogController,
          ),
          actions: <Widget>[
            MaterialButton(
              elevation: 5.0,
              child: Text('Submit'),
              onPressed: () {
                print(dialogController.text);
                getBooksByTitle(dialogController.text);
                var text=dialogController.text;
                Navigator.of(context).pop(text);
              },
            )
          ],
        );
      },
    );
  }

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
          author = bookData[i]['author'];
          imgUrl = bookData[i]['imageLinks']['smallThumbnail'];
          isbn = bookData[i]['isbn']['isbn_10'];
//          print(title);
//          print(url);
        } catch (e) {
          print(e);
          continue;
        }
        setState(() {
          showSpinner = false;
          booksInfo.add(Book(
              title: title,
              author: author,
              smallThumbnail: imgUrl,
              isbn_10: isbn));
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
        author = bookData['author'];
        imgUrl = bookData['image']['smallThumbnail'];
        isbn = bookData['isbn']['isbn_10'];
//        print(title);
//        print(url);
      } catch (e) {
        print('in outer try');
        print(e);
      }
      setState(() {
        showSpinner = false;
        booksInfo.add(Book(
            title: title,
            author: author,
            smallThumbnail: imgUrl,
            isbn_10: isbn));
      });
    }
  }

  void getBookByBar() async {
    try {
      String result = await BarcodeScanner.scan();
      print(result);
      getBooksByIsbn(result);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        print('camera acces denied');
      } else {
        print(e);
      }
    } on FormatException {
      print('You pressed the back button before scanning anything');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
     voiceTitle = ModalRoute.of(context).settings.arguments as String;
    print('in build $voiceTitle');
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'images/back.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          Scaffold(
            backgroundColor: Color(0xbbffffff),
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushNamed(context, HomeScreen.id);
                },
              ),
              backgroundColor: Color(0xff3ab397),
              title: Text('Add Book'),
            ),
            floatingActionButton: CustomSpeedDial(onISBNPressed: (value) {
              getBooksByIsbn(value);
            }, onTitlePressed: (value) {
              getBooksByTitle(value);
            }, onBarPressed: () {
              getBookByBar();
            }, onVoicePressed: () {
              getBookByVoice(context, 'Speech', kTextFieldDecoration);
            }),
            body: ModalProgressHUD(
              inAsyncCall: showSpinner,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
//                        print(index);
//                        print(bookData[index]);
                            //checking for null
                            print('isbn $isbn');
                            print('isbn_10 ${booksInfo[index].isbn_10}');
                            Navigator.pushNamed(context, BookInput.id,
                                arguments: booksInfo[index] ?? '1585424331');
                          },
                          child: BookCard(
                            title: booksInfo[index].title,
                            author: booksInfo[index].author,
                            isbn: booksInfo[index].isbn_10,
                            imgURL: booksInfo[index].smallThumbnail,
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
        ],
      ),
    );
  }
}
