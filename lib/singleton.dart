import 'package:dio/dio.dart';
import 'package:sultanpos/flavor.dart';
import 'package:sultanpos/http/httpapi.dart';
import 'package:sultanpos/http/authinterceptor.dart';
import 'package:sultanpos/preference.dart';

class Singleton {
  HttpAPI? httpApi;
  Preference? pref;
  static Singleton? _ins;

  static Singleton instance() {
    _ins ??= Singleton();
    return _ins!;
  }

  init() async {
    pref = Preference();
    await pref!.init();

    final interceptor = AuthInterceptor(
      Dio(BaseOptions(connectTimeout: 60000, receiveTimeout: 60000, sendTimeout: 60000)),
      '${Flavor.baseUrl}/login/refresh',
      storeAccessToken: (loginResponse) {},
    );
    httpApi = HttpAPI.create(Flavor.baseUrl!, interceptor);
  }
}
