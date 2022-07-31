import 'package:dio/dio.dart';
import 'package:sultanpos/flavor.dart';
import 'package:sultanpos/http/authinterceptor.dart';
import 'package:sultanpos/http/httpapi.dart';
import 'package:sultanpos/model/auth.dart';
import 'package:sultanpos/preference.dart';
import 'package:sultanpos/state/auth.dart';
import 'package:sultanpos/state/cashier.dart';
import 'package:sultanpos/state/master.dart';
import 'package:sultanpos/state/navigation.dart';
import 'package:sultanpos/state/product.dart';

class AppState {
  static final AppState _singleton = AppState._internal();

  factory AppState() {
    return _singleton;
  }

  AppState._internal();

  bool initted = false;
  AuthState? authState;
  NavigationState? navState;
  ProductState? productState;
  MasterState? masterState;
  CashierState? cashierState;

  init() async {
    if (initted) return;
    initted = true;
    await Preference().init();
    final interceptor = AuthInterceptor(Dio(BaseOptions(baseUrl: Flavor.baseUrl!)), "/auth/login/refresh", storeAccessToken: _tokenRefreshed);
    final httpAPI = HttpAPI.create(Flavor.baseUrl!, interceptor);
    navState = NavigationState();
    authState = AuthState(httpAPI);
    productState = ProductState(httpAPI);
    masterState = MasterState(httpAPI);
    cashierState = CashierState(httpAPI);
    await AppState().authState!.loadLogin();
  }

  _tokenRefreshed(LoginResponse token) {
    Preference().storeAuth(token.normalizeDate());
  }

  navigateTo(String path) {
    navState!.navigatorKey.currentState!.pushReplacementNamed(path);
  }
}
