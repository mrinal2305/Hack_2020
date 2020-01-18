//import 'package:flutter/material.dart';
//import 'package:speech_recognition/speech_recognition.dart';
//
//class CustomDialog extends StatefulWidget {
//  final title;
//  final message;
//  final Function onPress;
//  CustomDialog({this.title,this.message,this.onPress});
//
//  @override
//  _CustomDialogState createState() => _CustomDialogState();
//}
//
//class _CustomDialogState extends State<CustomDialog> {
//  SpeechRecognition _speechRecognition;
//
//  bool _isAvailable = false;
//
//  bool _isListening = false;
//
//  String resultText = "";
//
//  @override
//  void initState() {
//    super.initState();
//    initSpeechRecognizer();
//  }
//  Future<String> createAlertDialog(
//      BuildContext context, String heading, InputDecoration deco) {
//    TextEditingController customController = TextEditingController();
//    return showDialog(
//        context: context,
//        builder: (context) {
//          return AlertDialog(
//            backgroundColor: Colors.tealAccent,
//            title: Text('${widget.title}'),
//            content: Text('${widget.message}'),
//            actions: <Widget>[
//              FlatButton(
//                child: Icon(Icons.cancel),
//
//                color: Colors.deepOrange,
//                onPressed: () {
//                  if (_isListening)
//                    _speechRecognition.cancel().then(
//                          (result) => setState(() {
//                        _isListening = result;
//                        resultText = "";
//                      }),
//                    );
//                },
//              ),
//              FlatButton(
//                child: Icon(Icons.mic),
//                onPressed: () {
//                  if (_isAvailable && !_isListening)
//                    _speechRecognition
//                        .listen(locale: "en_US")
//                        .then((result) => print('$result'));
//                },
//                color: Colors.pink,
//              ),
//              FlatButton(
//                child: Icon(Icons.stop),
//                color: Colors.deepPurple,
//                onPressed: () {
//                  if (_isListening)
//                    _speechRecognition.stop().then(
//                          (result) => setState(() => _isListening = result),
//                    );
//                },
//              ),
//              Text(
//                resultText,
//                style: TextStyle(fontSize: 24.0),
//              )
//
//            ],
//          );
//        });
//  }
//
//  void initSpeechRecognizer() {
//    _speechRecognition = SpeechRecognition();
//
//    _speechRecognition.setAvailabilityHandler(
//          (bool result) => setState(() => _isAvailable = result),
//    );
//
//    _speechRecognition.setRecognitionStartedHandler(
//          () => setState(() => _isListening = true),
//    );
//
//    _speechRecognition.setRecognitionResultHandler(
//          (String speech) => setState(() => resultText = speech),
//    );
//
//    _speechRecognition.setRecognitionCompleteHandler(
//          () => setState(() => _isListening = false),
//    );
//
//    _speechRecognition.activate().then(
//          (result) => setState(() => _isAvailable = result),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//
//    return AlertDialog(
//      backgroundColor: Colors.tealAccent,
//      title: Text('${widget.title}'),
//      content: Text('${widget.message}'),
//      actions: <Widget>[
//        FlatButton(
//          child: Icon(Icons.cancel),
//
//          color: Colors.deepOrange,
//          onPressed: () {
//            if (_isListening)
//              _speechRecognition.cancel().then(
//                    (result) => setState(() {
//                  _isListening = result;
//                  resultText = "";
//                }),
//              );
//          },
//        ),
//        FlatButton(
//          child: Icon(Icons.mic),
//          onPressed: () {
//            if (_isAvailable && !_isListening)
//              _speechRecognition
//                  .listen(locale: "en_US")
//                  .then((result) => print('$result'));
//          },
//          color: Colors.pink,
//        ),
//        FlatButton(
//          child: Icon(Icons.stop),
//          color: Colors.deepPurple,
//          onPressed: () {
//            if (_isListening)
//              _speechRecognition.stop().then(
//                    (result) => setState(() => _isListening = result),
//              );
//          },
//        ),
//        Text(
//          resultText,
//          style: TextStyle(fontSize: 24.0),
//        )
//
//      ],
//    );
//  }
//}
//
////
////Future<String> createAlertDialog(
////    BuildContext context, String heading, InputDecoration deco) {
////  TextEditingController customController = TextEditingController();
////  return showDialog(
////      context: context,
////      builder: (context) {
////        return AlertDialog(
////          backgroundColor: Colors.tealAccent,
////          title: Text('${widget.title}'),
////          content: Text('${widget.message}'),
////          actions: <Widget>[
////            FlatButton(
////              child: Icon(Icons.cancel),
////
////              color: Colors.deepOrange,
////              onPressed: () {
////                if (_isListening)
////                  _speechRecognition.cancel().then(
////                        (result) => setState(() {
////                      _isListening = result;
////                      resultText = "";
////                    }),
////                  );
////              },
////            ),
////            FlatButton(
////              child: Icon(Icons.mic),
////              onPressed: () {
////                if (_isAvailable && !_isListening)
////                  _speechRecognition
////                      .listen(locale: "en_US")
////                      .then((result) => print('$result'));
////              },
////              color: Colors.pink,
////            ),
////            FlatButton(
////              child: Icon(Icons.stop),
////              color: Colors.deepPurple,
////              onPressed: () {
////                if (_isListening)
////                  _speechRecognition.stop().then(
////                        (result) => setState(() => _isListening = result),
////                  );
////              },
////            ),
////            Text(
////              resultText,
////              style: TextStyle(fontSize: 24.0),
////            )
////
////          ],
////        );
////      });
////}