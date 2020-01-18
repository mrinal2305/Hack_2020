import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lbs/services/firebase_helpers.dart';
import 'saved_books/personal_book_screen.dart';
import 'package:lbs/elements/issued_books.dart';

class IssuedPage extends StatefulWidget {
  static const String id = "issued_books_screens.dart";

  @override
  _IssuedPageState createState() => _IssuedPageState();
}

class _IssuedPageState extends State<IssuedPage> {
  final databaseReference = Firestore.instance;
  String getRollFromEmail(String email){
    String roll='';
    for(int i=0;i<email.length;i++){
      if(email[i]=='@'){
        break;
      }
      roll+=email[i];
    }
    return roll;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context).settings.arguments as String;
    final roll=getRollFromEmail(email);
    print(roll);
    print(email);
    return Scaffold(
      appBar: AppBar(
        title: Text('Library Issued Books'),
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('Issued Books'),
                ],
              ),
              Divider(
                height: 20.0,
                color: Colors.black,
                endIndent: 20.0,
                indent: 20.0,
              ),
              StreamBuilder<DocumentSnapshot>(
                stream: DatabaseService().studentStream(roll),
                builder: (context, snapshot) {
                   try{
                     print(snapshot.data);
                     if(!snapshot.hasData){
                       return Center(
                         child: CircularProgressIndicator(),
                       );
                     }
                     final books=snapshot.data['books'];
                     List<IssuedBookCard> book=[];
                     for(var b in books){
                       book.add(IssuedBookCard(bookTitle: b['title'],issueDate: b['issueDate'],isbn: b['isbn'],fine: b['fine'],author: b['author'],returnDate: b['returnDate'],));
                     }
                     return Column(
                       children: book,
                     );
                   }catch(e){
                     print(e);
                     return Center(child: Text('No Issued Books',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),));
                   }



                },
              ),
            ],
          ),
        ),
      ),
    );

//                StudentBookCard(bookTitle: 'Harry potter',author: 'J k Rowling',isbn: '627676736762',fee: '400',issueDate: '14/09/18',imgUrl: 'https://assets.wordpress.envato-static.com/uploads/2018/02/Harry-Potter-Original-Covers.png',),
//                StudentBookCard(bookTitle: 'Harry potter',author: 'J k Rowling',isbn: '627676736762',fee: '400',issueDate: '14/09/18',imgUrl: 'https://assets.wordpress.envato-static.com/uploads/2018/02/Harry-Potter-Original-Covers.png',)
  }

  void getData() {
    databaseReference
        .collection('student')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });
  }
}

class StudentInfo extends StatelessWidget {
  //final imgURl;
  final studentName;
  final imgUrl;
  final rollNo;
  final branch;
  final mobileNumber;
  final dob;
  final email;

  StudentInfo(
      {this.imgUrl,
        this.branch,
        this.dob,
        this.mobileNumber,
        this.rollNo,
        this.studentName,
        this.email});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        //height: 100,
//      width: 200,
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Flexible(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Column(
//              child: Image(
//                image: NetworkImage(imgURL),
//              ),

                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24.0),
                      child: Card(
                        elevation: 5.0,
                        child: Image(
                          image: NetworkImage(imgUrl),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Name : $studentName',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontFamily: ('Nunito'),
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0),
                    ),
                    Text(
                      'Roll : $rollNo',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontFamily: ('Nunito'),
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0),
                    ),
                    Text(
                      'Branch : $branch',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontFamily: ('Nunito'),
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0),
                    ),
                    Text(
                      'D.O.B : $dob',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontFamily: ('Nunito'),
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0),
                    ),
                    Text(
                      'Mobile Number : $mobileNumber',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontFamily: ('Nunito'),
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0),
                    ),
                    Text(
                      'Email : $email',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontFamily: ('Nunito'),
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0),
                    ),
                  ],
                )),
          ],
        ),
      ),
      Divider(
        color: Colors.grey.withOpacity(0.5),
        height: 20.0,
        indent: 20.0,
        endIndent: 20.0,
      )
    ]);
  }
}

class StudentBookCard extends StatelessWidget {
  //final imgURl;
  final bookTitle;
  final imgUrl;
  final author;
  final isbn;
  final issueDate;
  final fee;

  StudentBookCard(
      {this.bookTitle,
        this.imgUrl,
        this.author,
        this.isbn,
        this.fee,
        this.issueDate});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        //height: 100,
//      width: 200,
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Flexible(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Column(
//              child: Image(
//                image: NetworkImage(imgURL),
//              ),

                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24.0),
                      child: Card(
                        elevation: 5.0,
                        child: Image(
                          image: NetworkImage(imgUrl),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Title : $bookTitle',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontFamily: ('Nunito'),
                          fontWeight: FontWeight.w700,
                          fontSize: 18.0),
                    ),
                    Text(
                      'Author : $author',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontFamily: ('Nunito'),
                          fontWeight: FontWeight.w700,
                          fontSize: 18.0),
                    ),
                    Text(
                      'Book ID : $isbn',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontFamily: ('Nunito'),
                          fontWeight: FontWeight.w700,
                          fontSize: 18.0),
                    ),
                    Text(
                      'Fine : $fee',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontFamily: ('Nunito'),
                          fontWeight: FontWeight.w700,
                          fontSize: 18.0),
                    ),
                    Text(
                      'IssueDate : $issueDate',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontFamily: ('Nunito'),
                          fontWeight: FontWeight.w700,
                          fontSize: 18.0),
                    ),
                  ],
                )),
          ],
        ),
      ),
      Divider(
        color: Colors.grey.withOpacity(0.5),
        height: 20.0,
        indent: 20.0,
        endIndent: 20.0,
      )
    ]);
  }
}



//SavedBookDetails(
//bookTitle: b['title'],
//author: b['author'],
//isbn: b['isbn'],
//imgUrl: b['imgUrl'],
//)