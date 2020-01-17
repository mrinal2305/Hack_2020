import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:librarian/constants.dart';
import 'package:librarian/services/firebase_helpers.dart';

class SearchScreen extends StatefulWidget {
  static const id = 'search_screen';

  @override
  _SearchScreenState createState() => new _SearchScreenState();
}


class _SearchScreenState extends State<SearchScreen> {
  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
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
      SearchService().searchByTitle(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['title'].startsWith(capitalizedValue)) {
          setState(() {
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
        body: Column(children: <Widget>[
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
              return GestureDetector(
                onTap: () {
//                        print(index);
//                        print(bookData[index]);
                  //checking for null
                },
                child: BuildResultCard(bookTitle: 'hello'),
              );
            },
            itemCount: tempSearchStore.length,
          ),
        ]));
  }
}

class BuildResultCard extends StatelessWidget {
  //final imgURL;
  final bookTitle;

  BuildResultCard({this.bookTitle});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
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
                          image: NetworkImage(
                              'https://img1.od-cdn.com/ImageType-400/0211-1/84F/DEA/86/%7B84FDEA86-2E03-4EC5-B3ED-B966A8C3025D%7DImg400.jpg'),
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
                      bookTitle,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: ('Nunito'),
                          fontWeight: FontWeight.w700,
                          fontSize: 18.0),
                    ),
                    Text(
                      'Author J K Rowling',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontFamily: ('Nunito'),
                          fontWeight: FontWeight.w700,
                          fontSize: 18.0),
                    ),
                    Text(
                      'isbn 123243434343',
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
    ]);
  }
}
