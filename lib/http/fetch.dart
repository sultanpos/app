import 'package:dio/dio.dart';
import 'package:sultanpos/flavor.dart';
import 'package:sultanpos/model/error.dart';

class Fetch {
  final String basePath;
  final Dio dio;

  static Fetch? _def;

  Fetch(this.basePath, this.dio);

  _handleError(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        throw ErrorResponse(ErrorResponse.errorCodeTimeout, "request timeout");
      case DioExceptionType.cancel:
        throw ErrorResponse(ErrorResponse.errorCodeCanceled, "request canceled");
      case DioExceptionType.badResponse:
        {
          if (err.response!.data is Map<String, dynamic>) {
            throw ErrorResponse.fromJson(err.response!.data);
          } else {
            throw ErrorResponse(err.response!.statusCode!, "response unknown error");
          }
        }
      case DioExceptionType.badCertificate:
        throw ErrorResponse(ErrorResponse.errorBadCertificate, "bad certificate");
      case DioExceptionType.connectionError:
        throw ErrorResponse(ErrorResponse.errorConnection, "connection error");
      default:
        throw ErrorResponse(ErrorResponse.errorUnknown, "unknown error");
    }
  }

  post(String? path, {required Map<String, dynamic> data, bool skipAuth = false}) async {
    assert(path != null);
    try {
      final response =
          await dio.post('$basePath$path', data: data, options: skipAuth ? Options(extra: {'skipAuth': true}) : null);
      return response;
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  put(String? path, {required Map<String, dynamic> data, bool skipAuth = false}) async {
    assert(path != null);
    try {
      final response =
          await dio.put('$basePath$path', data: data, options: skipAuth ? Options(extra: {'skipAuth': true}) : null);
      return response;
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  get(String? path, {Map<String, dynamic>? queryParameters, bool skipAuth = false}) async {
    assert(path != null);
    try {
      final response = await dio.get('$basePath$path',
          queryParameters: queryParameters, options: skipAuth ? Options(extra: {'skipAuth': true}) : null);
      return response;
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  delete(String? path, {Map<String, dynamic>? queryParameters, bool skipAuth = false}) async {
    assert(path != null);
    try {
      final response = await dio.delete('$basePath$path',
          queryParameters: queryParameters, options: skipAuth ? Options(extra: {'skipAuth': true}) : null);
      return response;
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  Fetch instance() {
    _def ??= Fetch(
      Flavor.baseUrl!,
      Dio(
        BaseOptions(
          connectTimeout: const Duration(minutes: 1),
          receiveTimeout: const Duration(minutes: 1),
          sendTimeout: const Duration(minutes: 1),
        ),
      ),
    );
    return _def!;
  }
}
