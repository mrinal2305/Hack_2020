import 'package:flutter/material.dart';
const imgIsNull =
    'https://assets.wordpress.envato-static.com/uploads/2018/02/Harry-Potter-Original-Covers.png';
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

//  void removeBookFromStudent() async {
//    var db=Firestore.instance;
//    Map<String, String> issuedBook = {
//      'isbn': isbn,
//      'title': bookTitle,
//      'issueDate': '12-01-20',
//      'returnDate': '12-02-20',
//    };
//    print(issuedBook);
//    var roll = '1706011';
//    final studentCollection = db.collection('student');
//    await studentCollection.document(roll).updateData({
//      'books': FieldValue.arrayRemove([issuedBook])
//    });
//  }

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
              child: Column(
                children: <Widget>[
                  Padding(
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
                ],
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