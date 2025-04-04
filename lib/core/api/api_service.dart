import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:one_store_delivery/core/utils/ansi_color.dart';
import 'package:one_store_delivery/core/utils/app_keys.dart';
import 'package:one_store_delivery/core/utils/cache_helper.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log(
            AnsiColor.colorize(
              "Request: [${options.method}] ${options.uri.toString()}",
              AnsiColor.magenta,
            ),
            name: "API REQUEST",
          );
          if (options.data != null) {
            log(
              AnsiColor.colorize(
                "Request Data: ${options.data}",
                AnsiColor.green,
              ),
              name: "API REQUEST",
            );
          }
          return handler.next(options); // Continue the request
        },
        onResponse: (response, handler) {
          log(
            AnsiColor.colorize(
              "Response: [${response.statusCode}] ${response.requestOptions.uri.toString()}",
              AnsiColor.blue,
            ),
            name: "API RESPONSE",
          );
          // log(
          //   AnsiColor.colorize(
          //     "Response Data: ${response.data}",
          //     AnsiColor.green,
          //   ),
          //   name: "API RESPONSE",
          // );
          return handler.next(response); // Continue the response
        },
        onError: (DioException error, handler) {
          log(
            AnsiColor.colorize(
              "Error: [${error.response?.statusCode}] ${error.requestOptions.uri.toString()}",
              AnsiColor.red,
            ),
            name: "API ERROR",
          );
          log(
            AnsiColor.colorize(
              "Error Details: ${error.message}",
              AnsiColor.yellow,
            ),
            name: "API ERROR",
          );
          if (error.response?.data != null) {
            log(
              AnsiColor.colorize(
                "Error Data: ${error.response?.data}",
                AnsiColor.red,
              ),
              name: "API ERROR",
            );
          }
          return handler.next(error); // Continue the error
        },
      ),
    );
  }

  Future<void> _setHeaders(
      {bool isLogin = false, String language = 'en'}) async {
    dio.options.headers['Accept-Language'] = language;

    if (!isLogin) {
      String? token = await CacheHelper.getData(key: AppKeys.kToken);
      if (token != null && token.isNotEmpty) {
        dio.options.headers["Authorization"] = token;
      }
    }
  }

  Future<dynamic> get(
      {required String endPoint, CancelToken? cancelToken}) async {
    await _setHeaders(language: 'ar');
    debugPrint(
        'GET Request to: $endPoint with token: ${dio.options.headers["Authorization"]}');

    final response = await dio.get(endPoint, cancelToken: cancelToken);
    return response.data;
  }

  Future<Map<String, dynamic>> getWithBody({
    required String endPoint,
    required dynamic data,
    CancelToken? cancelToken,
  }) async {
    await _setHeaders(language: 'en');
    final response =
        await dio.get(endPoint, data: data, cancelToken: cancelToken);
    return response.data;
  }

  Future<Map<String, dynamic>> post({
    required String endPoint,
    dynamic data,
    bool isLogin = false,
    CancelToken? cancelToken,
  }) async {
    await _setHeaders(isLogin: isLogin);
    final response =
        await dio.post(endPoint, data: data, cancelToken: cancelToken);
    return response.data;
  }

  Future<Map<String, dynamic>> put({
    required String endPoint,
    required dynamic data,
  }) async {
    await _setHeaders();
    final response = await dio.put(endPoint, data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> delete({
    required String endPoint,
    int? id,
  }) async {
    await _setHeaders();
    dio.options.headers['Content-Type'] = "application/json";
    final response = await dio.delete(id != null ? endPoint : endPoint);
    return response.data;
  }

  Future<Map<String, dynamic>> deleteMany({
    required String endPoint,
    required dynamic data,
  }) async {
    await _setHeaders();
    dio.options.headers['Content-Type'] = "application/json";
    final response = await dio.delete(endPoint, data: data);
    return response.data;
  }
}
