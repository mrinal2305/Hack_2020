class Book {
  String author;
  String avgRating;
//  List<String> ddc =List<String>();
  String ddc1;
  String ddc2;
  String description;
  String isbn_10;
  String isbn_13;
  String issued;
//  List<String> lcc=List<String>();
  String lcc1;
  String lcc2;
  String pageCount;
  String publisher;
  String smallThumbnail;
  String thumbnail;
  String title;
  String totalCopy;

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
