import 'networking.dart';

class BookModel{
  Future<dynamic> getBookDetailsByTitle(String bookTitle) async {

    NetworkHelper networkHelper=NetworkHelper(titleURL:'https://peaceful-river-61209.herokuapp.com/title_author/$bookTitle');
    var bookDetails=await networkHelper.getBookDataByTitle();
//    print('in bookdetailsmodel\n');
//    print(bookDetails.length);

    return bookDetails;
  }

  Future<dynamic> getBookDetailsByISBN(String bookISBN) async {
    NetworkHelper networkHelper=NetworkHelper(isbnURl:'https://peaceful-river-61209.herokuapp.com/isbn/$bookISBN');
    var bookDetails=await networkHelper.getBookDataByISBN();
//    print('in bookdetailbyisbnsmodel\n');
//    print(bookDetails);
    return bookDetails;
  }

}