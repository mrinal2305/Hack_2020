import 'package:lbs/elements/book_models.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class BookProvider with ChangeNotifier{
  List<BookModels> books;

  void initialState(){
    syncDataWithProvider();
  }
  void addBooks(BookModels _book){
    books.add(_book);
    updateSharedPreferences();
    notifyListeners();
  }
  int getBookLength(){
    return books.length;
  }
   void removeBooks(BookModels _book){
      books.removeWhere((book)=>book.isbn==_book.isbn);
      updateSharedPreferences();
      notifyListeners();
   }
   Future updateSharedPreferences() async{
    List<String> myBooks=books.map((f)=> json.encode(f.toJson())).toList();
    SharedPreferences pref=await SharedPreferences.getInstance();

    await pref.setStringList('books', myBooks);
  }

  Future syncDataWithProvider() async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    var results=pref.getStringList('books');
    if(results!=null){
     books=results.map((f) => BookModels.fromJson(json.decode(f))).toList();
    }
   notifyListeners();
  }
}