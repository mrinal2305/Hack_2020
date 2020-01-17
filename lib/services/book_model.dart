import 'networking.dart';

class BookModel{
  //for basic details
  static const String TitleUrl='https://peaceful-river-61209.herokuapp.com/title_author/';
  static const String IsbnUrl='https://peaceful-river-61209.herokuapp.com/isbn/';
  //for ddc only
  static const String DdcUrl='https://nameless-fortress-08601.herokuapp.com/ddc_lcc/';
  //for complete details
  static const String DetailsUrl='https://nameless-fortress-08601.herokuapp.com/details/';
  //for category of books
  static const String CategoryUrl='https://nameless-fortress-08601.herokuapp.com/category/';

  Future<dynamic> getBookDetailsByTitle(String bookTitle) async {
    var bookDetails=await NetworkHelper.getBookDataByTitle(TitleUrl+bookTitle);
    return bookDetails;
  }

  Future<dynamic> getBookDetailsByISBN(String bookISBN) async {
    var bookDetails=await NetworkHelper.getBookDataByISBN(IsbnUrl+bookISBN);
    return bookDetails;
  }

  Future<dynamic> getBookDDC(String bookDDC) async {
    var bookDetails=await NetworkHelper.getBookDDC(DdcUrl+bookDDC);
    return bookDetails;
  }

  //give complete details on the basis of nameless fortress
  Future<dynamic> getBookCompleteDetails(String isbnForDetails) async{
    var bookDetails=await NetworkHelper.getBookDetails(DetailsUrl+isbnForDetails);//complete details
    return bookDetails;
  }

  Future<dynamic> getBookCategory(String bookTitle)async{
    var bookDetails=await NetworkHelper.getBookCategory(CategoryUrl+bookTitle);
    return bookDetails;
  }
}