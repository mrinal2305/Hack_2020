import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:lbs/chatbot/fact_message.dart';
import 'package:lbs/constants.dart';
import 'package:flutter_tts/flutter_tts.dart';

class FlutterFactsDialogFlow extends StatefulWidget {
  static const String id="virtual_lib.dart";
  FlutterFactsDialogFlow({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FlutterFactsDialogFlowState createState() => new _FlutterFactsDialogFlowState();
}

class _FlutterFactsDialogFlowState extends State<FlutterFactsDialogFlow> {
  final String value='';
  final List<FactsMessage> _messages = <FactsMessage>[];
  final TextEditingController _textController = new TextEditingController();
  final FlutterTts flutterTts=FlutterTts();
  Future _speak(String rawText) async{
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(rawText);


  }


  Widget _queryInputWidget(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _submitQuery,
                decoration: InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () => _submitQuery(_textController.text)),
                  ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconButton(
                    icon: Icon(Icons.keyboard_voice),
                  ),
                )
              ],
            )


//            Container(
//              margin: EdgeInsets.symmetric(horizontal: 4.0),
//              child: IconButton(
//                  icon: Icon(Icons.send),
//                  onPressed: () => _submitQuery(_textController.text)),
//            ),
          ],
        ),
      ),
    );
  }

  void _dialogFlowResponse(query) async {
    _textController.clear();
    AuthGoogle authGoogle =
    await AuthGoogle(fileJson: "assets/library bot-f69f18d549ca.json").build();
    Dialogflow dialogFlow =
    Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse response = await dialogFlow.detectIntent(query);
    FactsMessage message = FactsMessage(
      text: response.getMessage() ??
          CardDialogflow(response.getListMessage()[0]).title,
      name: "Virtual Lib",
      type: false,
    );
    _speak(response.getMessage() ??
        CardDialogflow(response.getListMessage()[0]).title);
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _submitQuery(String text) {
    _textController.clear();
    FactsMessage message = new FactsMessage(
      text: text,
      name: "Student",
      type: true,
    );
    setState(() {
      _messages.insert(0, message);
    });
    _dialogFlowResponse(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Virtual Librarian"),
        backgroundColor: kPrimaryColor ,
      ),
      body: Column(children: <Widget>[
        Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true, //To keep the latest messages at the bottom
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            )),
        Divider(height: 1.0),
        Container(
          decoration: new BoxDecoration(color: Theme.of(context).cardColor),
          child: _queryInputWidget(context),
        ),
      ]),
    );
  }
}