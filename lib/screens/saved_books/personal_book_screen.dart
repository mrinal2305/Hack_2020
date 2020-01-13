import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lbs/providers/saved_books.dart';

class BookListScreen extends StatelessWidget {
  static const String id="personal_book_screen.dart";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
      ),
      body: Center(
        child: FutureBuilder(
          future: Provider.of<SavedBooks>(context, listen: false)
              .fetchAndSetBooks(),
          builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Center(
            child: CircularProgressIndicator(),
          )
              : Consumer<SavedBooks>(
            child: Text('Got no places, add some places!'),
            builder: (context, savedBooks, child) {
              return savedBooks.items.length <= 0
                  ? child
                  : ListView.builder(
                itemBuilder: (context, index) {
                  return MyCard(title:savedBooks.items[index].title,imgPath: savedBooks.items[index].imgUrl,);

                },
                itemCount: savedBooks.items.length,
              );
            },
          ),
        ),
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  final String title;
  //final Function onTap;
  final String imgPath;

  MyCard({this.title,this.imgPath});

  @override
  Widget build(BuildContext context) {
    final data=MediaQuery.of(context);
    return Card(
      color: Color(0xddffffff),
      elevation: 8,
//        borderOnForeground: false,
      child: Container(
        width:data.size.width-50.0,
        height: data.size.height/6,
        margin: EdgeInsets.only(left: 8, top: 8, bottom: 8),
        padding: EdgeInsets.all(12),
        child: Row(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.network(imgPath,scale: 10.0,),
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
    );
  }
}
