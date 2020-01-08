import 'networking.dart';

class BookModel{
  Future<dynamic> getBookDetails(String bookName) async {
    NetworkHelper networkHelper=NetworkHelper(url:'https://peaceful-river-61209.herokuapp.com/title_author/$bookName');
    var bookDetails=await networkHelper.getBookData();
//    print('in bookdetailsmodel\n');
//    print(bookDetails.length);

    return bookDetails;
  }
}