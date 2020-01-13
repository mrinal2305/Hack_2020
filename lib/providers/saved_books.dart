import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:lbs/elements/books.dart';
import 'package:lbs/services/db_helper.dart';

class SavedBooks with ChangeNotifier {
  List<Books> _items = [];

  List<Books> get items {
    return [..._items];
  }

  void addBook(Books books ) {
    _items.add(books);
    notifyListeners();
    DBHelper.insert(
      'user_books',
      {
        'isbn': books.isbn,
        'title': books.title,
        'imageUrl': books.imgUrl,
        'description': books.description,
        'author': books.author
      },
    );
  }

  Future<void> fetchAndSetBooks () async {
    final dataList = await DBHelper.getData('user_books');
    _items = dataList.map(
          (item) {
        return Books(
          isbn: item['isbn'],
          title: item['title'],
          imgUrl: item['imgUrl'],
          description: item['description'],
          author: item['author']
        );
      },
    ).toList();
    notifyListeners();
  }

}
