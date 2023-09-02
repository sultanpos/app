import 'package:dio/dio.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sultanpos/flavor.dart';
import 'package:sultanpos/http/authinterceptor.dart';
import 'package:sultanpos/http/httpapi.dart';
import 'package:sultanpos/http/loginterceptor.dart' as myinterceptor;
import 'package:sultanpos/http/websocket/websocket.dart';
import 'package:sultanpos/localfiledb/db.dart';
import 'package:sultanpos/model/auth.dart';
import 'package:sultanpos/model/category.dart';
import 'package:sultanpos/model/partner.dart';
import 'package:sultanpos/preference.dart';
import 'package:sultanpos/repository/local/sqliteproductrepository.dart';
import 'package:sultanpos/repository/rest/authrepo.dart';
import 'package:sultanpos/repository/rest/branchrepo.dart';
import 'package:sultanpos/repository/rest/cashiersession.dart';
import 'package:sultanpos/repository/rest/paymentmethodrepo.dart';
import 'package:sultanpos/repository/rest/pricegroup.dart';
import 'package:sultanpos/repository/rest/product.dart';
import 'package:sultanpos/repository/rest/purchase.dart';
import 'package:sultanpos/repository/rest/restrepository.dart';
import 'package:sultanpos/repository/rest/sale.dart';
import 'package:sultanpos/repository/rest/unitrepo.dart';
import 'package:sultanpos/state/auth.dart';
import 'package:sultanpos/state/cashier.dart';
import 'package:sultanpos/state/category.dart';
import 'package:sultanpos/state/global.dart';
import 'package:sultanpos/state/master.dart';
import 'package:sultanpos/state/navigation.dart';
import 'package:sultanpos/state/partner.dart';
import 'package:sultanpos/state/paymentmethod.dart';
import 'package:sultanpos/state/pricegroup.dart';
import 'package:sultanpos/state/printer.dart';
import 'package:sultanpos/state/productroot.dart';
import 'package:sultanpos/state/purchase.dart';
import 'package:sultanpos/state/setting.dart';
import 'package:sultanpos/state/unit.dart';
import 'package:sultanpos/sync/local/database.dart';
import 'package:sultanpos/sync/sync.dart';

class AppState {
  static final AppState _singleton = AppState._internal();

  factory AppState() {
    return _singleton;
  }

  AppState._internal();

  bool initted = false;
  late HttpAPI httpAPI;
  late WebSocketTransport websocketTransport;
  late GlobalState global;
  late PrinterState printer;
  late AuthState authState;
  late NavigationState navState;
  late ProductRootState productRootState;
  late MasterState masterState;
  late CashierRootState cashierState;
  late UnitState unitState;
  late PriceGroupState priceGroupState;
  late PartnerState partnerState;
  late CategoryState categoryState;
  late PurchaseState purchaseState;
  late PaymentMethodState paymentMethodState;
  late SettingState settingState;
  late Sync sync;
  late SqliteDatabase sqliteDatabase;

  init() async {
    if (initted) return;
    initted = true;
    initializeDateFormatting("id_ID", null);
    await Preference().init();
    await LocalFileDb().init();
    final dioInterceptor = Dio(BaseOptions(baseUrl: Flavor.baseUrl));
    dioInterceptor.interceptors.add(myinterceptor.LogInterceptor());
    final interceptor = AuthInterceptor(dioInterceptor, "/auth/login/refresh", storeAccessToken: _tokenRefreshed);

    //repo
    httpAPI = HttpAPI.create(Flavor.baseUrl, interceptor);
    websocketTransport = WebSocketTransport(Flavor.baseUrlWs, httpAPI);
    final branchRepo = RestBranchRepo(httpApi: httpAPI);
    final priceGroupRepo = RestPriceGroupRepo(httpApi: httpAPI);
    final productRepo = RestProductRepo(httpApi: httpAPI);
    final unitRepo = RestUnitRepo(httpApi: httpAPI);
    final partnerRepo = BaseRestCRUDRepository(path: '/partner', httpApi: httpAPI, creator: PartnerModel.fromJson);
    final categoryRepo = BaseRestCRUDRepository(path: '/category', httpApi: httpAPI, creator: CategoryModel.fromJson);
    final purchaseRepo = RestPurchaseRepo(httpApi: httpAPI);
    final cashierSessionRepo = RestCashierSessionRepo(httpApi: httpAPI);
    final paymentMethodRepo = RestPaymentMethodRepo(httpApi: httpAPI);
    final saleRepo = RestSaleRepo(httpApi: httpAPI);

    //state
    global = GlobalState(branchRepo, Preference());
    navState = NavigationState();
    authState = AuthState(repo: RestAuthRepo(httpAPI));
    productRootState = ProductRootState(repo: productRepo);
    masterState = MasterState();

    unitState = UnitState(repo: unitRepo);
    priceGroupState = PriceGroupState(repo: priceGroupRepo);
    partnerState = PartnerState(repo: partnerRepo, priceGroupRepo: priceGroupRepo);
    categoryState = CategoryState(repo: categoryRepo);
    purchaseState = PurchaseState(
      purchaseRepo: purchaseRepo,
      productRepo: productRepo,
    );
    paymentMethodState = PaymentMethodState(repo: paymentMethodRepo);
    printer = PrinterState(
      preference: Preference(),
      saleRepo: saleRepo,
      unitRepo: unitRepo,
      cashierSessionRepo: cashierSessionRepo,
    );
    settingState = SettingState(Preference());

    Preference().listen((msg) {
      if (msg == Preference.keyShouldCheckLocal) {
        setupCashier();
      }
    });

    // this loadlogin throw an error
    // if load login failed, then all code below it never get called
    await authState.loadLogin();
    await global.setupBranch(authState.claim!);
    afterLogin();
  }

  _tokenRefreshed(LoginResponse token) {
    Preference().storeAuth(token.normalizeDate());
  }

  setupCashier() {
    bool localCache = Preference().shouldCacheToLocal() ?? false;
    if (localCache) {
      final productRepo = SqliteProductRepository(db: sqliteDatabase);
      final paymentMethodRepo = RestPaymentMethodRepo(httpApi: httpAPI);
      final saleRepo = RestSaleRepo(httpApi: httpAPI);
      final cashierSessionRepo = RestCashierSessionRepo(httpApi: httpAPI);
      cashierState = CashierRootState(
        productRepo: productRepo,
        cashierSessionRepo: cashierSessionRepo,
        paymentMethodRepo: paymentMethodRepo,
        saleRepo: saleRepo,
      );
    } else {
      final productRepo = RestProductRepo(httpApi: httpAPI);
      final paymentMethodRepo = RestPaymentMethodRepo(httpApi: httpAPI);
      final saleRepo = RestSaleRepo(httpApi: httpAPI);
      final cashierSessionRepo = RestCashierSessionRepo(httpApi: httpAPI);
      cashierState = CashierRootState(
        productRepo: productRepo,
        cashierSessionRepo: cashierSessionRepo,
        paymentMethodRepo: paymentMethodRepo,
        saleRepo: saleRepo,
      );
    }
  }

  navigateTo(String path) {
    navState.navigateTo(path);
  }

  afterLogin() {
    sqliteDatabase = SqliteDatabase(global.companyId);
    setupCashier();
    websocketTransport.connect();
    startSync();
  }

  loggedOut() async {
    await AppState().websocketTransport.close();
    if (Preference().shouldCacheToLocal() ?? false) AppState().sync.stop();
    Preference().resetLogin();
  }

  startSync() async {
    if (Preference().shouldCacheToLocal() ?? false) {
      sync = Sync();
      await sqliteDatabase.open();
      await sync.init(httpAPI, sqliteDatabase, websocketTransport, global);
      sync.start();
    }
  }
}
