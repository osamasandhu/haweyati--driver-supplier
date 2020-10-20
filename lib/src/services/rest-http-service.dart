import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haweyati_supplier_driver_app/src/common/serializer/serializable.dart';

abstract class RestHttpService<T> {
  String get endpoint;

  static Dio _dio;
  static initiate(String baseUrl) {
    if (_dio == null) {
      _dio = Dio(BaseOptions(baseUrl: baseUrl));
      _dio.interceptors.add(AuthInterceptor());
    }
  }

  Future<T> $get({String path}) async {
    var __resp = (await _dio.get(path ?? endpoint));
    print(__resp.request.path);

    final resp = __resp.data;
    if (resp is String) {
      final _resp = jsonDecode(resp.toString());

      if (_resp is List) {
        return parse(_resp[0]);
      } else {
        return parse(_resp);
      }
    } else {
      if (resp is List) {
        return parse(resp[0]);
      } else {
        return parse(resp);
      }
    }
  }

  Future<List<T>> $getAll({String path}) async {
    final resp = (await _dio.get(path ?? endpoint)).data;

    if (resp is List) {
      return resp.map((e) => parse(e)).toList();
    } else {
      return [parse(resp)];
    }
  }

  Future $post({
    Serializable data,
  }) {}

  Future $patch({
    Serializable data,
  }) {}
  Future $delete() {}

  T parse(Map<String, dynamic> data);
}

class AuthInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options) async {
    final token = (await SharedPreferences.getInstance()).getString('access_token');
    if (token != null) options.headers['Authorization'] = 'Bearer $token';

    return super.onRequest(options);
  }
}
