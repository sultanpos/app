import 'package:dio/dio.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sultanpos/flavor.dart';
import 'package:sultanpos/http/authinterceptor.dart';
import 'package:sultanpos/http/httpapi.dart';
import 'package:sultanpos/http/loginterceptor.dart' as myinterceptor;
import 'package:sultanpos/localfiledb/db.dart';
import 'package:sultanpos/model/auth.dart';
import 'package:sultanpos/model/category.dart';
import 'package:sultanpos/model/partner.dart';
import 'package:sultanpos/model/pricegroup.dart';
import 'package:sultanpos/model/product.dart';
import 'package:sultanpos/model/purchase.dart';
import 'package:sultanpos/model/unit.dart';
import 'package:sultanpos/preference.dart';
import 'package:sultanpos/repository/restrepository.dart';
import 'package:sultanpos/state/auth.dart';
import 'package:sultanpos/state/cashier.dart';
import 'package:sultanpos/state/category.dart';
import 'package:sultanpos/state/master.dart';
import 'package:sultanpos/state/navigation.dart';
import 'package:sultanpos/state/partner.dart';
import 'package:sultanpos/state/pricegroup.dart';
import 'package:sultanpos/state/productroot.dart';
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
  late ProductRootState productRootState;
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
    initializeDateFormatting("id_ID", null);
    await Preference().init();
    await LocalFileDb().init();
    final dioInterceptor = Dio(BaseOptions(baseUrl: Flavor.baseUrl!));
    dioInterceptor.interceptors.add(myinterceptor.LogInterceptor());
    final interceptor = AuthInterceptor(dioInterceptor, "/auth/login/refresh", storeAccessToken: _tokenRefreshed);
    httpAPI = HttpAPI.create(Flavor.baseUrl!, interceptor);
    navState = NavigationState();
    authState = AuthState(httpAPI);
    shareState = ShareState(httpAPI);
    productRootState =
        ProductRootState(repo: RestCRUDRepository(path: '/product', httpApi: httpAPI, creator: ProductModel.fromJson));
    masterState = MasterState(httpAPI);
    cashierState = CashierState(httpAPI);
    unitState = UnitState(repo: RestCRUDRepository(path: '/unit', httpApi: httpAPI, creator: UnitModel.fromJson));
    priceGroupState = PriceGroupState(
        repo: RestCRUDRepository(path: '/pricegroup', httpApi: httpAPI, creator: PriceGroupModel.fromJson));
    partnerState =
        PartnerState(repo: RestCRUDRepository(path: '/partner', httpApi: httpAPI, creator: PartnerModel.fromJson));
    categoryState =
        CategoryState(repo: RestCRUDRepository(path: '/category', httpApi: httpAPI, creator: CategoryModel.fromJson));
    purchaseState = PurchaseState(
        repo: RestCRUDRepository(path: '/purchase', httpApi: httpAPI, creator: PurchaseModel.fromJson),
        itemRepo: RestCRUDRepository(path: '/purchase', httpApi: httpAPI, creator: PurchaseItemModel.fromJson));
    await AppState().authState.loadLogin();
  }

  _tokenRefreshed(LoginResponse token) {
    Preference().storeAuth(token.normalizeDate());
  }

  navigateTo(String path) {
    navState.navigateTo(path);
  }
}
