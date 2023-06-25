import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint(
        'Request: ${_time()} [${options.method}] url: ${options.uri.toString()}; body: ${options.data.toString()}; query: ${options.queryParameters}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        'Response: ${_time()} [${response.requestOptions.method}:${response.statusCode}] url: ${response.realUri.toString()}; body: ${response.data.toString()}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.type == DioExceptionType.badResponse) {
      debugPrint(
          'Error ${_time()} Response: [${err.response!.statusCode}] url: ${err.response!.realUri}; body: ${err.response!.data.toString()}}');
    } else {
      debugPrint('Error ${_time()} Response: ${err.toString()}');
    }
    super.onError(err, handler);
  }

  _time() {
    return DateTime.now().toLocal().toString();
  }
}
