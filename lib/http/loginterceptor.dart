import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('Request: [${options.method}] url: ${options.uri.toString()}; body: ${options.data.toString()}; query: ${options.queryParameters}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('Response: [${response.statusCode}] url: ${response.realUri.toString()}; body: ${response.data.toString()}');
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.type == DioErrorType.response) {
      debugPrint('Error Response: [${err.response!.statusCode}] url: ${err.response!.realUri}; body: ${err.response!.data.toString()}}');
    } else {
      debugPrint('Error Response: ${err.toString()}');
    }
    super.onError(err, handler);
  }
}
