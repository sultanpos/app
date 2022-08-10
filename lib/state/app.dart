import 'package:dio/dio.dart';
import 'package:sultanpos/flavor.dart';
import 'package:sultanpos/http/authinterceptor.dart';
import 'package:sultanpos/http/httpapi.dart';
import 'package:sultanpos/http/loginterceptor.dart' as myinterceptor;
import 'package:sultanpos/model/auth.dart';
import 'package:sultanpos/preference.dart';
import 'package:sultanpos/state/auth.dart';
import 'package:sultanpos/state/cashier.dart';
import 'package:sultanpos/state/master.dart';
import 'package:sultanpos/state/navigation.dart';
import 'package:sultanpos/state/pricegroup.dart';
import 'package:sultanpos/state/product.dart';
import 'package:sultanpos/state/unit.dart';

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
  UnitState? unitState;
  PriceGroupState? priceGroupState;

  init() async {
    if (initted) return;
    initted = true;
    await Preference().init();
    final dioInterceptor = Dio(BaseOptions(baseUrl: Flavor.baseUrl!));
    dioInterceptor.interceptors.add(myinterceptor.LogInterceptor());
    final interceptor = AuthInterceptor(dioInterceptor, "/auth/login/refresh", storeAccessToken: _tokenRefreshed);
    final httpAPI = HttpAPI.create(Flavor.baseUrl!, interceptor);
    navState = NavigationState();
    authState = AuthState(httpAPI);
    productState = ProductState(httpAPI);
    masterState = MasterState(httpAPI);
    cashierState = CashierState(httpAPI);
    unitState = UnitState(httpAPI);
    priceGroupState = PriceGroupState(httpAPI);
    await AppState().authState!.loadLogin();
  }

  _tokenRefreshed(LoginResponse token) {
    Preference().storeAuth(token.normalizeDate());
  }

  navigateTo(String path) {
    navState!.navigateTo(path);
  }
}
