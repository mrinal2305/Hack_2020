//import 'package:flutter/material.dart';
//import 'package:librarian/constants.dart';
//import 'package:firebase_database/firebase_database.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//
//class SearchScreen extends StatefulWidget {
//  static const id = 'search_screen';
//
//  @override
//  _SearchScreenState createState() => _SearchScreenState();
//}
//
//class _SearchScreenState extends State<SearchScreen> {
//  String searchQuery;
//
//  //FireBase related variables
////  final db = FirebaseDatabase.instance;
//  final databaseReference = Firestore.instance;
//
//  DatabaseReference bookTitleRef;
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    bookTitleRef = FirebaseDatabase.instance.reference().child('book_title');
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return SafeArea(
//      child: Scaffold(
//        backgroundColor: Color(0xfff7f7f7),
//        appBar: AppBar(
//          backgroundColor: Color(0xfff7f7f7),
//          title: TextField(
//            decoration: kTextFieldDecoration.copyWith(
//              hintText: 'Enter book title',
//              suffixIcon: IconButton(
//                icon: Icon(
//                  Icons.search,
//                ),
//                onPressed: () {
//                  print(searchQuery);
//                },
//              ),
//            ),
//            onChanged: (value) {
//              searchQuery = value;
//            },
//          ),
//        ),
//        body: ListView(
//          children: <Widget>[
//            LibraryBookCard(),
//          ],
//        ),
//      ),
//    );
//  }
//}
//
//class LibraryBookCard extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      height: 85.0,
//      margin: EdgeInsets.all(8),
//      child: Card(
//        elevation: 1.0,
//        child: GestureDetector(
//          onTap: () {},
//          child: Row(
//            children: <Widget>[
//              Image.asset(
//                'images/collaboration.png',
//              ),
//              SizedBox(
//                width: 20,
//              ),
//              Column(
////                mainAxisAlignment: MainAxisAlignment.start,
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  Text(
//                    'Title',
//                    style: kTitleTextStyle,
//                  ),
//                  Text(
//                    'Author',
//                  ),
//                  Text(
//                    'Copy Available',
//                  ),
//                  Text(
//                    'Rating',
//                  )
//                ],
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}
//
////class for holding FireBase db table BookTitle
//class BookTitle {
//  String title;
//  String author;
//  String rating;
//  String availableCopy;
//  String publisher;
//  String pageCount;
//  String totalCopy;
//  String imgUrl;
//  String description;
//  String isbn;
//
//  BookTitle({this.title});
//
//  BookTitle.fromSnapShot(DataSnapshot snapshot) {
//    author=snapshot.value[title]['author'];
//    rating=snapshot.value[title]['averageRating'];
//    availableCopy=snapshot.value[title]['available_copy'];
//    publisher=snapshot.value[title]['publisher'];
//    pageCount=snapshot.value[title]['pageCount'];
//    totalCopy=snapshot.value[title]['total_copy'];
//    imgUrl=snapshot.value[title]['imageLinks'];
//    description=snapshot.value[title]['description'];
//    isbn=snapshot.value[title]['isbn_10'];
//  }
//
////  Student.fromSnapShot(DataSnapshot snapshot) {
//////    regNo = snapshot.value;
////    cl = snapshot.value['class'];
////    fine = snapshot.value['fine'];
////    name = snapshot.value['name'];
////    roll = snapshot.value['roll'];
////  }
//
////  toJson() {
////    return {
////      title:{
////        'class': author,
////        'fine': rating,
////        'name': ,
////        'roll': publisher,
////      }
////    };
////  }
//}
