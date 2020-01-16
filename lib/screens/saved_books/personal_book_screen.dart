import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lbs/providers/saved_books.dart';

class BookListScreen extends StatelessWidget {
  static  String imageUrl;
  static const String id="personal_book_screen.dart";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Books'),
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
                  try{
                   imageUrl=savedBooks.items[index].smallThumbnail;
                   print(imageUrl);

                  }catch(e){
                    imageUrl='https://d1lp72kdku3ux1.cloudfront.net/title_instance/329/small/20111.jpg';
                  }
                  return SavedBookDetails(
                             bookTitle:savedBooks.items[index].title,
                             author: savedBooks.items[index].author,
                             isbn: savedBooks.items[index].isbn_10,
                             imgUrl: imageUrl,
                  );

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



class SavedBookDetails extends StatelessWidget {
  //final imgURl;
  final bookTitle;
  final imgUrl;
  final author;
  final isbn;


  SavedBookDetails({this.bookTitle,this.imgUrl,this.author,this.isbn});

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
                          'Isbn : $isbn',
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
