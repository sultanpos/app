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
import 'package:sultanpos/model/unit.dart';
import 'package:sultanpos/preference.dart';
import 'package:sultanpos/repository/rest/authrepo.dart';
import 'package:sultanpos/repository/rest/branchrepo.dart';
import 'package:sultanpos/repository/rest/pricegroup.dart';
import 'package:sultanpos/repository/rest/product.dart';
import 'package:sultanpos/repository/rest/purchase.dart';
import 'package:sultanpos/repository/rest/restrepository.dart';
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

    //repo
    httpAPI = HttpAPI.create(Flavor.baseUrl!, interceptor);
    final branchRepo = RestBranchRepo(httpApi: httpAPI);
    final priceGroupRepo = RestPriceGroupRepo(httpApi: httpAPI);
    final productRepo = RestProductRepo(httpApi: httpAPI);
    final unitRepo = BaseRestCRUDRepository(path: '/unit', httpApi: httpAPI, creator: UnitModel.fromJson);
    final partnerRepo = BaseRestCRUDRepository(path: '/partner', httpApi: httpAPI, creator: PartnerModel.fromJson);
    final categoryRepo = BaseRestCRUDRepository(path: '/category', httpApi: httpAPI, creator: CategoryModel.fromJson);
    final purchaseRepo = RestPurchaseRepo(httpApi: httpAPI);

    //state
    navState = NavigationState();
    authState = AuthState(repo: RestAuthRepo(httpAPI));
    shareState = ShareState(branchRepo: branchRepo, priceGroupRepo: priceGroupRepo);
    productRootState = ProductRootState(repo: productRepo);
    masterState = MasterState();
    cashierState = CashierState();
    unitState = UnitState(repo: unitRepo);
    priceGroupState = PriceGroupState(repo: priceGroupRepo);
    partnerState = PartnerState(repo: partnerRepo);
    categoryState = CategoryState(repo: categoryRepo);
    purchaseState = PurchaseState(
      purchaseRepo: purchaseRepo,
      productRepo: productRepo,
    );
    await AppState().authState.loadLogin();
  }

  _tokenRefreshed(LoginResponse token) {
    Preference().storeAuth(token.normalizeDate());
  }

  navigateTo(String path) {
    navState.navigateTo(path);
  }
}
