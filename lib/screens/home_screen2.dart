import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()));

class HomePage extends StatefulWidget {
  static const String id = 'home_screen2.dart';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//  final List<String> _listItem = [
//    'assets/images/two.jpg',
//    'assets/images/three.jpg',
//    'assets/images/four.jpg',
//    'assets/images/five.jpg',
//    'assets/images/one.jpg',
//    'assets/images/two.jpg',
//    'assets/images/three.jpg',
//    'assets/images/four.jpg',
//    'assets/images/five.jpg',
//  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.menu),
        title: Text("Home"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              width: 36,
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(10)),
              child: Center(child: Text("0")),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: ListView(

          children: <Widget>[
            MyCard(cardTitle: 'Library',cardButton: 'Press me',),

            MyCard(cardTitle: 'Personal',cardButton: 'Push me',),
            MyCard(cardTitle: 'Search',cardButton: 'Smash me',)
          ],
        ),
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  final String cardTitle;
  final String cardButton;
  MyCard({@required this.cardTitle,this.cardButton});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: AssetImage('images/liba.jpg'), fit: BoxFit.fill)),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                    Colors.black.withOpacity(.4),
                    Colors.black.withOpacity(.2),
                  ])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    cardTitle,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),

                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
//
        ],
      ),
    );
  }
}
