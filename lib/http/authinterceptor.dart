import 'package:dio/dio.dart';
import 'package:sultanpos/model/auth.dart';

typedef StoreAccessToken = void Function(LoginResponse loginResponse);

class AuthInterceptor extends QueuedInterceptor {
  final Dio dio;
  final String authRefreshUrl;
  final StoreAccessToken? storeAccessToken;
  String? accessToken;
  String? refreshToken;
  DateTime? lifeTime;

  AuthInterceptor(this.dio, this.authRefreshUrl, {this.storeAccessToken});

  setAccessToken(String? accessToken, String? refreshToken, DateTime? lifeTime) {
    this.accessToken = accessToken;
    this.refreshToken = refreshToken;
    this.lifeTime = lifeTime;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final skipAuth = options.extra.containsKey("skipAuth");
    if (!skipAuth) {
      final errorData = {"code": 401, "message": "unauthorize"};
      if (accessToken == null || accessToken == "") {
        handler.reject(DioError(
            requestOptions: options,
            type: DioErrorType.response,
            response: Response(requestOptions: options, statusCode: 401, statusMessage: "Unauthorized", data: errorData)));
      } else if (lifeTime!.isBefore(DateTime.now())) {
        dio
            .post(authRefreshUrl, data: {"refresh_token": refreshToken}, options: Options(headers: {"Content-Type": "application/json"}))
            .then((value) {
          final loginResponse = LoginResponse.fromJson(value.data);
          if (storeAccessToken != null) storeAccessToken!(loginResponse);
          accessToken = loginResponse.accessToken;
          refreshToken = loginResponse.refreshToken;
          lifeTime = DateTime.now().add(Duration(seconds: loginResponse.expiresIn - (5 * 60)));
          options.headers["Authorization"] = 'Bearer $accessToken';
          handler.next(options);
        }).onError((error, stackTrace) {
          handler.reject(DioError(
              requestOptions: options,
              type: DioErrorType.response,
              response: Response(requestOptions: options, statusCode: 401, statusMessage: "Unauthorized", data: errorData)));
        });
      } else {
        options.headers["Authorization"] = 'Bearer $accessToken';
        handler.next(options);
      }
    } else {
      handler.next(options);
    }
  }
}
