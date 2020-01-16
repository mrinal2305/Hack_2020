import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class IssuedPage extends StatefulWidget {
  static const String id="issued_books_screens.dart";
  @override
  _IssuedPageState createState() => _IssuedPageState();
}

class _IssuedPageState extends State<IssuedPage> {
  final databaseReference = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Issue Reissue'),
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                StudentBookCard(bookTitle: 'Harry potter',author: 'J k Rowling',isbn: '627676736762',fee: '400',issueDate: '14/09/18',imgUrl: 'https://assets.wordpress.envato-static.com/uploads/2018/02/Harry-Potter-Original-Covers.png',),
                StudentBookCard(bookTitle: 'Harry potter',author: 'J k Rowling',isbn: '627676736762',fee: '400',issueDate: '14/09/18',imgUrl: 'https://assets.wordpress.envato-static.com/uploads/2018/02/Harry-Potter-Original-Covers.png',)
              ],
            ),

        ),
      ),
    );

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

  StudentInfo({this.imgUrl,this.branch,this.dob,this.mobileNumber,this.rollNo,this.studentName,this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
        children:<Widget>[
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
                            elevation:5.0,
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
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Name : $studentName',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontFamily: ('Nunito'),
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0
                          ),
                        ),
                        Text(
                          'Roll : $rollNo',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontFamily: ('Nunito'),
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0
                          ),
                        ),
                        Text(
                          'Branch : $branch',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontFamily: ('Nunito'),
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0
                          ),
                        ),
                        Text(
                          'D.O.B : $dob',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontFamily: ('Nunito'),
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0
                          ),
                        ),
                        Text(
                          'Mobile Number : $mobileNumber',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontFamily: ('Nunito'),
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0
                          ),
                        ),
                        Text(
                          'Email : $email',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontFamily: ('Nunito'),
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0
                          ),
                        ),

                      ],
                    )

                ),
              ],
            ),
          )
          ,
          Divider(
            color: Colors.grey.withOpacity(0.5),
            height: 20.0,
            indent: 20.0,
            endIndent: 20.0,

          )
        ]

    );
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

  StudentBookCard({this.bookTitle,this.imgUrl,this.author,this.isbn,this.fee,this.issueDate});

  @override
  Widget build(BuildContext context) {
    return Column(
        children:<Widget>[
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
                            elevation:5.0,
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
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Title : $bookTitle',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontFamily: ('Nunito'),
                            fontWeight: FontWeight.w700,
                            fontSize: 18.0
                        ),
                      ),
                      Text(
                        'Author : $author',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontFamily: ('Nunito'),
                            fontWeight: FontWeight.w700,
                            fontSize: 18.0
                        ),
                      ),
                      Text(
                        'Book ID : $isbn',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontFamily: ('Nunito'),
                            fontWeight: FontWeight.w700,
                            fontSize: 18.0
                        ),
                      ),
                      Text(
                        'Fine : $fee',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontFamily: ('Nunito'),
                            fontWeight: FontWeight.w700,
                            fontSize: 18.0
                        ),
                      ),
                      Text(
                        'IssueDate : $issueDate',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontFamily: ('Nunito'),
                            fontWeight: FontWeight.w700,
                            fontSize: 18.0
                        ),
                      ),
                    ],
                  )

                ),
              ],
            ),
          )
          ,
          Divider(
            color: Colors.grey.withOpacity(0.5),
            height: 20.0,
            indent: 20.0,
            endIndent: 20.0,

          )
        ]

    );
  }
}



