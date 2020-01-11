import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper{
  NetworkHelper({this.titleURL,this.isbnURl,this.ddcURL});
  final String titleURL;
  final String isbnURl;
  final String ddcURL;

  //work on json array and return list of json
  Future getBookDataByTitle() async{
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
  Future getBookDataByISBN() async{
    try {
      http.Response response = await http.get(isbnURl);
      if (response.statusCode == 200) {
        String jsonData = response.body;
//        print(jsonData);
        if(jsonData!=null)
        return jsonDecode(jsonData) ;
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
  Future getBookDDc() async{
    try{
      http.Response response =await http.get(ddcURL);
      if(response.statusCode==200){
        String jsonArrayData=response.body;
        if(jsonArrayData!=null)
          return jsonDecode(jsonArrayData) as List;
        else
          print('null received');
      } else {
        print('response code erroe');
        print(response.statusCode);
      }
    } catch(e){
      print(e);
    }
  }

}