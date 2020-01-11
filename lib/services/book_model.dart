import 'networking.dart';
import 'dart:async';

class BookModel{
  //for basic details
  static const String TitleUrl='https://peaceful-river-61209.herokuapp.com/title_author/';
  static const String IsbnUrl='https://peaceful-river-61209.herokuapp.com/isbn/';

  //for ddc only
  static const String DdcUrl='https://nameless-fortress-08601.herokuapp.com/ddc_lcc/';
  static const String DescriptionUrl='https://nameless-fortress-08601.herokuapp.com/details/';

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

  Future<dynamic> getBookDescription(String isbn) async {
    NetworkHelper networkHelper=NetworkHelper(ddcURL: DescriptionUrl+isbn);
    var bookDetails=await networkHelper.getBookDescription();
    print(bookDetails);
    return bookDetails;
  }

}