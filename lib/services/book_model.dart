import 'networking.dart';

class BookModel{
  //for basic details
  static const String TitleUrl='https://peaceful-river-61209.herokuapp.com/title_author/';
  static const String IsbnUrl='https://peaceful-river-61209.herokuapp.com/isbn/';

  //for ddc only
  static const String DdcUrl='https://nameless-fortress-08601.herokuapp.com/ddc_lcc/';

  //for complete details
  static const String detailsUrl='https://nameless-fortress-08601.herokuapp.com/details/';

  Future<dynamic> getBookDetailsByTitle(String bookTitle) async {
    NetworkHelper networkHelper=NetworkHelper(titleURL: TitleUrl+bookTitle);
    var bookDetails=await networkHelper.getBookDataByTitle();
    return bookDetails;
  }

  Future<dynamic> getBookDetailsByISBN(String bookISBN) async {
    NetworkHelper networkHelper=NetworkHelper(isbnURl:IsbnUrl+bookISBN);
    var bookDetails=await networkHelper.getBookDataByISBN();
    return bookDetails;
  }

  Future<dynamic> getBookDDC(String bookDDC) async {
    NetworkHelper networkHelper=NetworkHelper(ddcURL: DdcUrl+bookDDC);
    var bookDetails=await networkHelper.getBookDDc();
    return bookDetails;
  }

  //give complete details on the basis of nameless fortress
  Future<dynamic> getBookCompleteDetails(String isbnForDetails) async{
    NetworkHelper networkHelper=NetworkHelper(isbnForDetailsUrl: detailsUrl+isbnForDetails);
    var bookDetails=await networkHelper.getBookDetails();//complete details
    return bookDetails;
  }

}