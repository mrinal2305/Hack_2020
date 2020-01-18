import 'dart:math';

import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  //work on json array and return list of json
  static Future getBookDataByTitle(String titleURL) async {
    try {
      http.Response response = await http.get(titleURL);
      if (response.statusCode == 200) {
        String jsonArrayData = response.body;
        return jsonDecode(jsonArrayData) as List;
      } else {
        print('in book by title');
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  //write function carefully
  static Future getBookDataByISBN(String isbnURL) async {
    try {
      http.Response response = await http.get(isbnURL);
      if (response.statusCode == 200) {
        String jsonData = response.body;
//        print(jsonData);
        if (jsonData != null)
          return jsonDecode(jsonData);
        else
          print('null received');
      } else {
        print('response code error in bookIsbn');
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  //for getting ddc
  static Future getBookDDC(String ddcURL) async {
    try {
      http.Response response = await http.get(ddcURL);
      if (response.statusCode == 200) {
        String jsonArrayData = response.body;
        if (jsonArrayData != null)
          return jsonDecode(jsonArrayData) as List;
        else
          print('null received');
      } else {
        print('response code error in bookDDC');
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  //for getting book complete details by nameless fortress by isbn
  static Future getBookDetails(String isbnForDetailsURL) async {
    try {
      http.Response response = await http.get(isbnForDetailsURL);
      if (response.statusCode == 200) {
        String jsonData = response.body;
        if (jsonData != null)
          return jsonDecode(jsonData);
        else
          print('null received in bookdetails');
      } else {
        print('response code error');
        print(response.statusCode);
      }
    } catch (e) {
      print('in try of bookdetails by isbn');
      print(e);
    }
  }

  static Future getBookCategory(String titleURL) async {
    try {
      http.Response response = await http.get(titleURL);
      if (response.statusCode == 200) {
        String jsonData = response.body;
        if (jsonData != null)
          return jsonDecode(jsonData);
        else
          print('null recieved in bookCategory');
      } else {
        print('response code error for category');
        print(response.statusCode);
      }
    } catch (e) {
      print('in try of bookCategory');
      print(e);
    }
  }

  static Future getSubCategory(String descUrl) async {
    String subCategoryUrl='https://intense-thicket-08147.herokuapp.com/subCategory/?text=';
    try {
      http.Response response = await http.get(subCategoryUrl+descUrl);
      if (response.statusCode == 200) {
        String jsonData = response.body;
        if (jsonData != null)
          return jsonDecode(jsonData);
        else
          print('null recieved in subcategory');
      } else {
        print('response code error for subcategory');
        print(response.statusCode);
      }
    } catch (e) {
      print('in try of subcategory');
      print(e);
    }
  }

  static Future getConcept(String descUrl) async {
    String conceptUrl='https://intense-thicket-08147.herokuapp.com/concept/?text=';
    try {
      http.Response response = await http.get(conceptUrl+descUrl);
      if (response.statusCode == 200) {
        String jsonData = response.body;
        if (jsonData != null)
          return jsonDecode(jsonData);
        else
          print('null recieved in concept');
      } else {
        print('response code error for concept');
        print(response.statusCode);
      }
    } catch (e) {
      print('in try of concept');
      print(e);
    }
  }
}
