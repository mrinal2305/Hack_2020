import 'package:flutter/material.dart';




class BookDisplay extends StatefulWidget {
  static const String id="book_display.dart";
  @override
  _BookDisplayState createState() => _BookDisplayState();
}

class _BookDisplayState extends State<BookDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Container(
          child:ListView(
            children: <Widget>[
              _buildBookItem(),
              _buildBookItem(),
              _buildBookItem()
            ],

          )
        ),
      )
    );

  }

  Widget _buildBookItem() {
    return Container(
      height: 85.0,
      //padding: EdgeInsets.only(left: 2.0, right: 2.0),
      child: Card(
        //padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        //semanticContainer: true,
          elevation: 1.0,
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {

            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: Row(
                        children: [
                          SizedBox(
                            width: 2.0,
                          ),
//                          Image(
//
//
//                              fit: BoxFit.fitHeight,
//
//                              height: 75.0,
//                              width: 50.0
//                          ),
                          SizedBox(width: 15.0),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'hello banda',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold
                                    )
                                ),
                                Text(
                                    'how are you',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 15.0,
                                        color: Colors.grey
                                    )
                                )
                              ]
                          )
                        ]
                    )
                ),
//                IconButton(
//                    icon: Icon(Icons.check,color: Colors.black,),
//                    onPressed: () {
//                      setState(() {
//                      });
//                    }
//                )

              ],
            ),
          )),
    );
  }
}
