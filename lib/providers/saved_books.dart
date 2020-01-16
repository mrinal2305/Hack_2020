import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:lbs/elements/books.dart';
import 'package:lbs/services/db_helper.dart';

class SavedBooks with ChangeNotifier {
  List<Book> _items = [];

  List<Book> get items {
    return [..._items];
  }

  void addBook(Book books ) {
    _items.add(books);
    notifyListeners();
    DBHelper.insert(
      'user_books',
      {
        'isbn': books.isbn_10,
        'title': books.title,
        'imgUrl': books.smallThumbnail,
        'description': books.description,
        'author': books.author
      },
    );
  }

  Future<void> fetchAndSetBooks () async {
    final dataList = await DBHelper.getData('user_books');
    _items = dataList.map(
          (item) {
        return Book(
          isbn_10: item['isbn'],
          title: item['title'],
          smallThumbnail: item['imgUrl'],
          description: item['description'],
          author: item['author']
        );
      },
    ).toList();
    notifyListeners();
  }

}
