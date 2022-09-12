import 'package:dio/dio.dart';
import 'package:sultanpos/flavor.dart';
import 'package:sultanpos/http/authinterceptor.dart';
import 'package:sultanpos/http/httpapi.dart';
import 'package:sultanpos/http/loginterceptor.dart' as myinterceptor;
import 'package:sultanpos/model/auth.dart';
import 'package:sultanpos/preference.dart';
import 'package:sultanpos/state/auth.dart';
import 'package:sultanpos/state/cashier.dart';
import 'package:sultanpos/state/category.dart';
import 'package:sultanpos/state/master.dart';
import 'package:sultanpos/state/navigation.dart';
import 'package:sultanpos/state/partner.dart';
import 'package:sultanpos/state/pricegroup.dart';
import 'package:sultanpos/state/product.dart';
import 'package:sultanpos/state/purchase.dart';
import 'package:sultanpos/state/share.dart';
import 'package:sultanpos/state/unit.dart';

class AppState {
  static final AppState _singleton = AppState._internal();

  factory AppState() {
    return _singleton;
  }

  AppState._internal();

  bool initted = false;
  late HttpAPI httpAPI;
  late AuthState authState;
  late NavigationState navState;
  late ShareState shareState;
  late ProductState productState;
  late MasterState masterState;
  late CashierState cashierState;
  late UnitState unitState;
  late PriceGroupState priceGroupState;
  late PartnerState partnerState;
  late CategoryState categoryState;
  late PurchaseState purchaseState;

  init() async {
    if (initted) return;
    initted = true;
    await Preference().init();
    final dioInterceptor = Dio(BaseOptions(baseUrl: Flavor.baseUrl!));
    dioInterceptor.interceptors.add(myinterceptor.LogInterceptor());
    final interceptor = AuthInterceptor(dioInterceptor, "/auth/login/refresh", storeAccessToken: _tokenRefreshed);
    httpAPI = HttpAPI.create(Flavor.baseUrl!, interceptor);
    navState = NavigationState();
    authState = AuthState(httpAPI);
    shareState = ShareState(httpAPI);
    productState = ProductState(httpAPI);
    masterState = MasterState(httpAPI);
    cashierState = CashierState(httpAPI);
    unitState = UnitState(httpAPI);
    priceGroupState = PriceGroupState(httpAPI);
    partnerState = PartnerState(httpAPI);
    categoryState = CategoryState(httpAPI);
    purchaseState = PurchaseState(httpAPI);
    await AppState().authState.loadLogin();
  }

  _tokenRefreshed(LoginResponse token) {
    Preference().storeAuth(token.normalizeDate());
  }

  navigateTo(String path) {
    navState.navigateTo(path);
  }
}
