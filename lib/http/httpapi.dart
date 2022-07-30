import 'package:dio/dio.dart';
import 'package:sultanpos/http/authinterceptor.dart';
import 'package:sultanpos/http/fetch.dart';
import 'package:sultanpos/http/loginterceptor.dart' as myinterceptor;
import 'package:sultanpos/model/auth.dart';
import 'package:sultanpos/model/base.dart';
import 'package:flutter/foundation.dart';

class HttpAPI {
  final Fetch fetch;
  final AuthInterceptor interceptor;
  HttpAPI._internal({required this.fetch, required this.interceptor});

  factory HttpAPI.create(String basePath, AuthInterceptor interceptor) {
    final dio = Dio(BaseOptions(connectTimeout: 60000, receiveTimeout: 60000, sendTimeout: 60000));
    if (kDebugMode) dio.interceptors.add(myinterceptor.LogInterceptor());
    dio.interceptors.add(interceptor);
    final fetch = Fetch(basePath, dio);
    return HttpAPI._internal(fetch: fetch, interceptor: interceptor);
  }

  setLogin(LoginResponse login) {
    interceptor.setAccessToken(login.accessToken, login.refreshToken, DateTime.now().add(Duration(seconds: login.expiresIn)));
  }

  setLogout() {
    interceptor.setAccessToken(null, null, null);
  }

  Future post<T>(BaseModel data, {String? path, bool skipAuth = false}) async {
    final ret = await fetch.post(path ?? data.path(), data: data.toJson(), skipAuth: skipAuth);
    return data.responseFromJson(ret.data) as T;
  }

  Future put<T>(String publicID, BaseModel data, {String? path, bool skipAuth = false}) async {
    final ret = await fetch.put('${path ?? data.path()}/$publicID', data: data.toJson(), skipAuth: skipAuth);
    return data.responseFromJson(ret.data) as T;
  }

  Future delete(String publicID, {required String path, bool skipAuth = false}) {
    return fetch.delete('$path/$publicID', skipAuth: skipAuth);
  }

  Future get<T>(String publicID, {required T Function(Map<String, dynamic> json) fromJsonFunc, required String path, bool skipAuth = false}) async {
    final ret = await fetch.get('$path/$publicID', skipAuth: skipAuth);
    return fromJsonFunc(ret.data);
  }
}
