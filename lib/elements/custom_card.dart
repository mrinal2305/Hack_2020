import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

const imgIsNull =
    'https://assets.wordpress.envato-static.com/uploads/2018/02/Harry-Potter-Original-Covers.png';

class HomeCard extends StatelessWidget {
  final String title;
  final Function onTap;
  final String imgPath;

  HomeCard(this.title, this.onTap,this.imgPath);

  @override
  Widget build(BuildContext context) {
    final data=MediaQuery.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Color(0xddffffff),
        elevation: 8,
//        borderOnForeground: false,
        child: Container(
          width:data.size.width-50.0,
          height: data.size.height/6,
          margin: EdgeInsets.only(left: 8, top: 8, bottom: 8),
          padding: EdgeInsets.all(12),
          child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset(imgPath,scale: 10.0,),
              SizedBox(
                width: 50,
              ),
              Text(title,style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400
              ),),
            ],
          ),
//          height: 120.00,
//          width: 300,
        ),
      ),
    );
  }
}

class StudentInfoCard extends StatelessWidget {
  //final imgURl;
  final studentName;
  final imgUrl;
  final rollNo;
  final year;
  final regNo;
  final branch;

//  final mobileNumber;
//  final dob;
//  final email;

  StudentInfoCard({
    this.imgUrl,
    this.branch,
    this.regNo,
    this.year,
//      this.dob,
//      this.mobileNumber,
    this.rollNo,
    this.studentName,
//    this.email,
  });

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
                padding: EdgeInsets.symmetric(horizontal: 22.0),
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
                          fontWeight: FontWeight.w700, fontSize: 12.0),
                    ),
                    Text(
                      'Roll : $rollNo',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 12.0),
                    ),
                    Text(
                      'Branch : $branch',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 12.0),
                    ),
                    Text(
                      'Year : $year',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 12.0),
                    ),
                    Text(
                      'Registration ID : $regNo',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 12.0),
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

class IssuedBookCard extends StatelessWidget {
  //final imgURl;
  final bookTitle;
  final imgUrl;
  final author;
  final isbn;
  final issueDate;
  final returnDate;
  final fine;

  IssuedBookCard(
      {this.bookTitle,
        this.imgUrl,
        this.author,
        this.isbn,
        this.fine,
        this.issueDate,
        this.returnDate});

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
                padding: EdgeInsets.symmetric(horizontal: 22.0),
                child: Column(
//              child: Image(
//                image: NetworkImage(imgURL),
//              ),

                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18.0),
                      child: Card(
                        elevation: 5.0,
                        child: Image(
                          image: NetworkImage(imgUrl ?? imgIsNull),
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
                    style:
                    TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
                  ),
                  Text(
                    'Author : $author',
                    textAlign: TextAlign.end,
                    style:
                    TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
                  ),
                  Text(
                    'ISBN : $isbn',
                    textAlign: TextAlign.end,
                    style:
                    TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
                  ),
                  Text(
                    'Fine : $fine',
                    textAlign: TextAlign.end,
                    style:
                    TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
                  ),
                  Text(
                    'IssueDate : $issueDate',
                    textAlign: TextAlign.end,
                    style:
                    TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
                  ),
                  Text(
                    'ReturnDate : $returnDate',
                    textAlign: TextAlign.end,
                    style:
                    TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
                  ),
                ],
              ),
            ),
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