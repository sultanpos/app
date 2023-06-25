import 'package:dio/dio.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:sultanpos/http/authinterceptor.dart';
import 'package:sultanpos/http/fetch.dart';
import 'package:sultanpos/http/loginterceptor.dart' as myinterceptor;
import 'package:sultanpos/model/auth.dart';
import 'package:sultanpos/model/base.dart';
import 'package:flutter/foundation.dart';
import 'package:sultanpos/model/claim.dart';
import 'package:sultanpos/model/listresult.dart';

class HttpAPI {
  final Fetch fetch;
  final AuthInterceptor interceptor;
  int? companyId;
  HttpAPI._internal({required this.fetch, required this.interceptor});

  factory HttpAPI.create(String basePath, AuthInterceptor interceptor) {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(minutes: 1),
        receiveTimeout: const Duration(minutes: 1),
        sendTimeout: const Duration(minutes: 1),
      ),
    );
    if (kDebugMode) dio.interceptors.add(myinterceptor.LogInterceptor());
    dio.interceptors.add(interceptor);
    final fetch = Fetch(basePath, dio);
    return HttpAPI._internal(fetch: fetch, interceptor: interceptor);
  }

  setLogin(LoginResponse login) {
    interceptor.setAccessToken(
        login.accessToken, login.refreshToken, DateTime.fromMillisecondsSinceEpoch(login.expiresIn));
    final claim = JWTClaim.fromJson(Jwt.parseJwt(login.accessToken));
    companyId = claim.companyId;
  }

  Future<LoginResponse> loginWithUsernamePassword(LoginUsernamePasswordRequest req) async {
    return post<LoginResponse>(req, "/auth/login", skipAuth: true, skipCompanyId: true);
  }

  Future logout(String refreshToken) async {
    await delete('/auth/login/$refreshToken', skipCompanyId: true);
    await delete('/auth/login', skipCompanyId: true);
    interceptor.setAccessToken(null, null, null);
    companyId = null;
  }

  Future<T> insert<T>(BaseModel data, {String? path}) {
    return post<T>(data, path ?? data.path() ?? "");
  }

  Future<T> update<T>(BaseModel data, int id, {String? path}) {
    return put<T>(data, '${path ?? data.path() ?? ""}/$id');
  }

  Future<T> getOne<T>(String path, {required T Function(Map<String, dynamic> json) fromJsonFunc}) {
    return get<T>(path, fromJsonFunc: fromJsonFunc);
  }

  Future<T> post<T>(BaseModel data, String path, {bool skipAuth = false, bool skipCompanyId = false}) async {
    final ret = await fetch.post(_generateUrl(path, skipCompanyId), data: data.toJson(), skipAuth: skipAuth);
    return data.responseFromJson(ret.data) as T;
  }

  Future<T> put<T>(BaseModel data, String path, {bool skipAuth = false, bool skipCompanyId = false}) async {
    final ret = await fetch.put(_generateUrl(path, skipCompanyId), data: data.toJson(), skipAuth: skipAuth);
    return data.responseFromJson(ret.data) as T;
  }

  Future delete(String path, {bool skipAuth = false, bool skipCompanyId = false}) {
    return fetch.delete(_generateUrl(path, skipCompanyId), skipAuth: skipAuth);
  }

  Future<T> get<T>(String path,
      {required T Function(Map<String, dynamic> json) fromJsonFunc,
      bool skipAuth = false,
      bool skipCompanyId = false}) async {
    final ret = await fetch.get(_generateUrl(path, skipCompanyId), skipAuth: skipAuth);
    return fromJsonFunc(ret.data);
  }

  Future<ListResult<T>> query<T extends BaseModel>(
    String path, {
    required T Function(Map<String, dynamic> json) fromJsonFunc,
    required limit,
    required offset,
    bool skipAuth = false,
    bool skipCompanyId = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    final params = queryParameters ?? {};
    params["limit"] = limit;
    params["start"] = offset;
    final ret = await fetch.get(_generateUrl(path, skipCompanyId), skipAuth: skipAuth, queryParameters: params);
    return ListResult.fromJson(ret.data, fromJsonFunc);
  }

  _generateUrl(String source, bool skipCompanyId) {
    return skipCompanyId ? source : '/company/$companyId$source';
  }
}
