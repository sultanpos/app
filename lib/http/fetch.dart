import 'package:dio/dio.dart';
import 'package:sultanpos/flavor.dart';
import 'package:sultanpos/model/error.dart';

class Fetch {
  final String basePath;
  final Dio dio;

  static Fetch? _def;

  Fetch(this.basePath, this.dio);

  _handleError(DioError err) {
    switch (err.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.receiveTimeout:
      case DioErrorType.sendTimeout:
        throw ErrorResponse(ErrorResponse.errorCodeTimeout, "request timeout");
      case DioErrorType.cancel:
        throw ErrorResponse(ErrorResponse.errorCodeCanceled, "request canceled");
      case DioErrorType.response:
        {
          if (err.response!.data is Map<String, dynamic>) {
            throw ErrorResponse.fromJson(err.response!.data);
          } else {
            throw ErrorResponse(err.response!.statusCode!, "response unknown error");
          }
        }
      default:
        throw ErrorResponse(ErrorResponse.errorUnknown, "unknown error");
    }
  }

  post(String? path, {required Map<String, dynamic> data}) async {
    assert(path != null);
    try {
      final response = await dio.post('$basePath$path', data: data);
      return response;
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  put(String? path, {required Map<String, dynamic> data}) async {
    assert(path != null);
    try {
      final response = await dio.put('$basePath$path', data: data);
      return response;
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  get(String? path, {Map<String, dynamic>? queryParameters}) async {
    assert(path != null);
    try {
      final response = await dio.get('$basePath$path', queryParameters: queryParameters);
      return response;
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  delete(String? path, {Map<String, dynamic>? queryParameters}) async {
    assert(path != null);
    try {
      final response = await dio.delete('$basePath$path', queryParameters: queryParameters);
      return response;
    } on DioError catch (e) {
      _handleError(e);
    }
  }

  Fetch instance() {
    _def ??= Fetch(Flavor.baseUrl!, Dio(BaseOptions(connectTimeout: 60000, receiveTimeout: 60000, sendTimeout: 60000)));
    return _def!;
  }
}
