import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:librarian/constants.dart';
import 'package:librarian/services/firebase_helpers.dart';

const imgIsNull =
    'https://assets.wordpress.envato-static.com/uploads/2018/02/Harry-Potter-Original-Covers.png';

class SearchScreen extends StatefulWidget {
  static const id = 'search_screen';

  @override
  _SearchScreenState createState() => new _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(String value) {
    print('in initiatesearch $value');
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    var capitalizedValue =
        value.substring(0, 1).toLowerCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService.searchByTitle(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
        }
      });
    } else {
      capitalizedValue =
          capitalizedValue[0].toUpperCase() + capitalizedValue.substring(1);
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['title'].startsWith(capitalizedValue)) {
          setState(() {
            print(element);
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text('Book search'),
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                onChanged: (val) {
                  initiateSearch(val);
                },
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      color: Colors.black,
                      icon: Icon(Icons.search),
                      iconSize: 20.0,
                      onPressed: () {
//                      Navigator.pop(context);
                      },
                    ),
                    contentPadding: EdgeInsets.only(left: 25.0),
                    hintText: 'Search by title',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0))),
              ),
            ),
            SizedBox(height: 10.0),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return BuildResultCard(
                  bookTitle: tempSearchStore[index]['title'] ?? 'null',
                  author: tempSearchStore[index]['author'] ?? 'null',
                  isbn: tempSearchStore[index]['isbn_10'] ?? 'null',
                  imgUrl: tempSearchStore[index]['smallThumbnail'] ?? imgIsNull,
                );
              },
              itemCount: tempSearchStore.length,
            ),
          ]),
        ));
  }
}

class BuildResultCard extends StatelessWidget {
  //final imgURL;
  final bookTitle;
  final imgUrl;
  final author;
  final isbn;

  BuildResultCard({this.bookTitle, this.author, this.isbn, this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Color(0xd3d3d3),
          //height: 100,
//      width: 200,
          width: double.infinity,
          child: Row(
            children: <Widget>[
              Flexible(
                flex: 4,
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 22.0),
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
                        '$bookTitle',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontFamily: ('Nunito'),
                            fontWeight: FontWeight.w700,
                            fontSize: 18.0),
                      ),
                      Text(
                        '$author',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontFamily: ('Nunito'),
                            fontWeight: FontWeight.w700,
                            fontSize: 18.0),
                      ),
                      Text(
                        '$isbn',
                        textAlign: TextAlign.justify,
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
      ],
    );
  }
}
