import 'package:dio/dio.dart';
import 'package:sultanpos/http/authinterceptor.dart';
import 'package:sultanpos/model/auth.dart';
import 'package:test/test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  test('Oauth access token interceptor', () async {
    final externalDio = Dio();
    final externalDioAdapter = DioAdapter(dio: externalDio);
    final internalDio = Dio();
    final internalDioAdapter = DioAdapter(dio: internalDio);
    LoginResponse? newLoginResponse;
    final loginResponse = LoginResponse("accessToken", "refreshToken", 600);
    const String path1 = "/path1";
    const String pathRefresh = "/refresh";

    final sltnInterceptor = AuthInterceptor(
      internalDio,
      pathRefresh,
      storeAccessToken: (loginRes) {
        newLoginResponse = loginRes;
      },
    );
    externalDioAdapter.onGet(path1, (server) {
      server.reply(200, {'status': 'ok'});
    });
    internalDioAdapter.onPost(pathRefresh, (server) {
      server.reply(200, loginResponse.toJson());
    }, data: {'refresh_token': 'refresh'});
    internalDioAdapter.onPost(pathRefresh, (server) {
      server.reply(400, {'code': 400, 'message': 'refresh token not found'});
    }, data: {'refresh_token': 'refreshFailed'});
    internalDioAdapter.onPost(pathRefresh, (server) {
      server.reply(200, loginResponse.toJson());
    }, data: {'refresh_token': 'refresh'});

    externalDio.interceptors.add(sltnInterceptor);

    var res = await externalDio.get(path1, options: Options(extra: {"skipAuth": true}));
    expect(200, res.statusCode);
    expect('ok', (res.data as Map<String, dynamic>)['status']);

    try {
      res = await externalDio.get(path1);
      expect(0, res.statusCode); // should not go here
    } on DioError catch (e) {
      expect(DioErrorType.response, e.type);
      expect(401, e.response!.statusCode);
    }

    sltnInterceptor.setAccessToken("token", "refresh", DateTime.now().add(const Duration(minutes: 10)));
    res = await externalDio.get(path1);
    expect(200, res.statusCode);

    sltnInterceptor.setAccessToken("token", "refreshFailed", DateTime.now().add(const Duration(minutes: -1)));
    try {
      res = await externalDio.get(path1);
      expect(0, res.statusCode); // should not go here
    } on DioError catch (e) {
      expect(DioErrorType.response, e.type);
      expect(401, e.response!.statusCode);
    }

    sltnInterceptor.setAccessToken("token", "refresh", DateTime.now().add(const Duration(minutes: -1)));
    res = await externalDio.get(path1);
    expect(200, res.statusCode);
    expect(true, newLoginResponse != null);
    expect(loginResponse.accessToken, newLoginResponse!.accessToken);
  });
}
