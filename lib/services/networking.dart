import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper({this.titleURL, this.isbnURl, this.ddcURL,this.isbnForDetailsUrl});

  final String titleURL;
  final String isbnURl;
  final String ddcURL;
  final String isbnForDetailsUrl;
  //work on json array and return list of json
  Future getBookDataByTitle() async {
    try {
      http.Response response = await http.get(titleURL);
      if (response.statusCode == 200) {
        String jsonArrayData = response.body;
        return jsonDecode(jsonArrayData) as List;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  //write function carefully
  Future getBookDataByISBN() async {
    try {
      http.Response response = await http.get(isbnURl);
      if (response.statusCode == 200) {
        String jsonData = response.body;
//        print(jsonData);
        if (jsonData != null)
          return jsonDecode(jsonData);
        else
          print('null received');
      } else {
        print('response code error');
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  //for getting ddc
  Future getBookDDc() async {
    try {
      http.Response response = await http.get(ddcURL);
      if (response.statusCode == 200) {
        String jsonArrayData = response.body;
        if (jsonArrayData != null)
          return jsonDecode(jsonArrayData) as List;
        else
          print('null received');
      } else {
        print('response code erroe');
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  //for getting book complete details by nameless fortress by isbn
  Future getBookDetails() async {
    try {
      http.Response response = await http.get(isbnForDetailsUrl);
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

  static Future getEmotion(String descUrl) async {
    String EmotionUrl='https://intense-thicket-08147.herokuapp.com/emotion/?text=';
    try {
      http.Response response = await http.get(EmotionUrl+descUrl);
      if (response.statusCode == 200) {
        String jsonData = response.body;
        if (jsonData != null)
          return jsonDecode(jsonData);
        else
          print('null recieved in emotion');
      } else {
        print('response code error for emotion');
        print(response.statusCode);
      }
    } catch (e) {
      print('in try of emotion');
      print(e);
    }
  }
}
