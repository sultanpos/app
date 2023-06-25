import 'package:dio/dio.dart';
import 'package:sultanpos/model/auth.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/error.dart';
import 'package:test/test.dart';

class Loader<T> {
  final BaseModel Function(Map<String, dynamic> json) fromJson;
  Loader(this.fromJson);

  T getData(Map<String, dynamic> json) {
    final d = fromJson(json);
    return d as T;
  }
}

class RequestResponse<T> {
  ErrorResponse? error;
  T? data;
}

class MyFetch {
  simulatThrow(DioExceptionType type) async {
    throw DioException(requestOptions: RequestOptions(path: "/"), type: type);
  }

  String _handle(DioException err) {
    if (err.type == DioExceptionType.cancel) {
      return err.toString();
    }
    throw "error not handled";
  }

  post(DioExceptionType? type) async {
    try {
      if (type != null) {
        await simulatThrow(type);
      }
      return "works";
    } on DioException catch (e) {
      return _handle(e);
    }
  }
}

void main() {
  test('Base model', () async {
    final jsonSource = {"username": "myusername", "password": "mypassword"};
    BaseModel? baseModel = LoginUsernamePasswordRequest.fromJson(jsonSource);
    final jsonValue = baseModel.toJson();
    expect(jsonValue["username"], jsonSource["username"]);
    expect(jsonValue["password"], jsonSource["password"]);

    final loader = Loader<LoginUsernamePasswordRequest>(LoginUsernamePasswordRequest.fromJson);
    final data = loader.getData(jsonSource);
    expect(data.username, jsonSource["username"]);
    expect(data.password, jsonSource["password"]);

    final fetch = MyFetch();
    try {
      await fetch.post(DioExceptionType.connectionTimeout);
    } catch (e) {
      expect(e.toString(), "error not handled");
    }
  });
}
