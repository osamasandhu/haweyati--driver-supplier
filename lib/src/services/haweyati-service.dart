import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:haweyati_supplier_driver_app/utils/toast_utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';


 // const apiUrl = "http://192.168.18.4:4000";
 // const apiUrl = "http://192.168.43.204:4000";
 const apiUrl = "http://192.168.10.3:4000";
 // const apiUrl = "http://128.199.69.75:4000";

abstract class HaweyatiService<T> {

  Dio dio = Dio();
  SharedPreferences prefs;

  Future<List<T>> getAll(String route) async {
   // print(route);
    print("$apiUrl/$route");
    prefs =  await SharedPreferences.getInstance();

    final response = await http.get('$apiUrl/$route',headers: {
      'Accept': 'application/json',
      'Authorization' : 'Bearer ${prefs.getString('token')}'
    },
    );

    switch(response.statusCode){
      case 200:
        final decodedData = await compute<String, List<Map<String, dynamic>>>(_decodeData, response.body);
        return decodedData.map<T>((item) => parse(item)).toList();
        break;
      case 401:
        var responseData = json.decode(response.body);
        print(responseData);
        break;
      case 404:
        throw Exception("404 error Error while fetching Data. from $apiUrl");
        break;
      case 405:
        throw Exception("405 error Error while fetching Data. from $apiUrl");
        break;
      case 422:
        throw Exception("422 error Error while fetching Data. from $apiUrl");
        break;
      case 500:
        throw Exception("${response.body} 500 error Error while fetching Data. from $apiUrl");
        break;
      default:
    }
//    if (response.statusCode == 200) {
//      final decodedData = await compute<String, List<Map<String, dynamic>>>(_decodeData, response.body);
//
//      return decodedData.map<T>((item) => parse(item)).toList();
//    } else {
//      throw Exception("Error while fetching Data. from $apiUrl");
//    }
  }
//
  static List<Map<String, dynamic>> _decodeData(String encodedData) {
    return jsonDecode(encodedData).cast<Map<String, dynamic>>();
  }

  static resolveImage(String url) {
    return "$apiUrl/uploads/$url";
  }

  T parse(Map<String, dynamic> item);

  static post(String route, data) async {
    Dio dio =  Dio();

    try {
      print('$apiUrl/$route');
      Response response = await dio.post("$apiUrl/$route", data: data,options: Options(

      ));
      print(response.data);
      return response;
    }
    on DioError catch(e) {
//      return e;


      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        print(e.message);
      }
      return e.response.data['message'];

    }
  }



  static patch(String route, data) async {
    Dio dio =  Dio();

    try {
      print('$apiUrl/$route');
      Response response = await dio.patch("$apiUrl/$route", data: data,options: Options(

      ));
      print(response.data);
      return response;
    }
    on DioError catch(e) {
//      return e;


      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        showErrorToast(e.response.data['message']);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        print(e.message);
      }
      return e.response.data['message'];

    }
  }


  static convertImgUrl(String url){
    return "$apiUrl/uploads/$url";
  }


  Future<T> getOne(String route) async {
    print("$apiUrl/$route");
    prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    print(token);

    try {
      final response = await dio.get('$apiUrl/$route',
          options: Options(
            headers: {
              'Accept': 'application/json',
              'Authorization' : 'Bearer $token'
            },
          )
      );
      return parse(response.data);
    }
    on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        print(e.message);
      }
      return e.response.data['message'];
    }

  }

}
