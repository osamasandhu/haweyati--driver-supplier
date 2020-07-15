import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

final apiUrl = "http://192.168.1.109:4000";

abstract class HaweyatiSupplierDriverService<T> {
  Dio dio = Dio();


  Future<List<T>> getAll(String route) async {
//    print(route);
//    print("$apiUrl/api/$route");
    final response = await http.get('$apiUrl/$route', headers: {
      'Accept': 'application/json',
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
  static List<Map<String, dynamic>> _decodeData(String encodedData) {
    return jsonDecode(encodedData).cast<Map<String, dynamic>>();
  }

  static post(String route,FormData data) async {
    Dio dio = Dio();
    try {
      Response res = await dio.post("$apiUrl/$route", data: data);
      return res;
    }
    on DioError catch (e){
      print(e.response.data);
    }
  }

  T parse(Map<String, dynamic> json);
}
