

class Book {
  String author='author';
  String avgRating='5';
//  List<String> ddc =List<String>();
  String ddc1='340';
  String ddc2='123';
  String description='description';
  String isbn_10;
  String isbn_13;
  int issued=1;
//  List<String> lcc=List<String>();
  String lcc1='lcc1';
  String lcc2='lcc2';
  String pageCount='234';
  String publisher='wiley';
  String smallThumbnail='small';
  String thumbnail='thumb';
  String title='title';
  int totalCopy=5;

  Book.initialize(){
     author='author';
     avgRating='5';
//  List<String> ddc =List<String>();
     ddc1='340';
     ddc2='123';
     description='description';
     isbn_10='isbn_10';
     isbn_13='isbn_13';
     issued=0;
//  List<String> lcc=List<String>();
     lcc1='lcc1';
     lcc2='lcc2';
     pageCount='234';
     publisher='wiley';
     smallThumbnail='small';
     thumbnail='thumb';
     title='title';
     totalCopy=10;
  }
  Book({
    this.title,
    this.smallThumbnail,
    this.isbn_10,
    this.author,
    this.description,
    this.ddc1,
    this.ddc2,
  });
}
