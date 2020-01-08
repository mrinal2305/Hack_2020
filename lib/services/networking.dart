import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper{
  NetworkHelper({this.url});
  final String url;

  //work on json array and return list of json
  Future getBookData() async{
    try {
      http.Response response = await http.get(url);
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

}