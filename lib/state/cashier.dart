import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/cashier.dart';
import 'package:sultanpos/repository/repository.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/cart.dart';
import 'package:sultanpos/util/format.dart';

class CashierRootState extends ChangeNotifier {
  final ProductRepository productRepo;
  final CashierSessionRepository cashierSessionRepo;
  final PaymentMethodRepository paymentMethodRepo;
  final SaleRepository saleRepo;

  final fgOpenValue = FormControl<String>(validators: [Validators.required]);
  final fgCloseValue = FormControl<String>(validators: [Validators.required]);
  late FormGroup formGroup;
  late FormGroup formGroupClose;

  int cashierId = 0;
  bool loadingInit = true;
  CashierSessionModel? currentSession;
  CashierSessionReportModel? report;
  bool cashierOpened = false;
  int currentCashierTabId = 0;
  bool saving = false;
  bool reportLoading = false;

  late List<CartState> cashierItems;

  CashierRootState({
    required this.productRepo,
    required this.cashierSessionRepo,
    required this.paymentMethodRepo,
    required this.saleRepo,
  }) {
    formGroup = FormGroup({
      'openValue': fgOpenValue,
    });
    formGroupClose = FormGroup({
      'closeValue': fgCloseValue,
    });
  }

  init() async {
    try {
      currentSession = await cashierSessionRepo.getActive();
      if (currentSession != null) {
        cashierOpened = true;
        setUpFirstCashierItem();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    loadingInit = false;
    notifyListeners();
  }

  openCashierWithoutSession() {
    cashierOpened = true;
    setUpFirstCashierItem();
    notifyListeners();
  }

  setUpFirstCashierItem() {
    cashierId = 0;
    cashierItems = [
      CartState(
        cashierId++,
        productRepo: productRepo,
        paymentMethodRepo: paymentMethodRepo,
        saleRepository: saleRepo,
        cashierSessionId: currentSession?.id ?? 0,
      )
    ];
    currentCashierTabId = cashierId - 1;
  }

  newTabCashier() {
    cashierItems.add(CartState(
      cashierId++,
      productRepo: productRepo,
      paymentMethodRepo: paymentMethodRepo,
      saleRepository: saleRepo,
      cashierSessionId: currentSession?.id ?? 0,
    ));
    currentCashierTabId = cashierItems.last.id;
    notifyListeners();
  }

  setCurrentTab(int id) {
    currentCashierTabId = id;
    notifyListeners();
  }

  closeTab(int id) {
    int index = cashierItems.indexWhere((element) => element.id == id);
    cashierItems.removeAt(index);
    if (cashierItems.length > index) {
      currentCashierTabId = cashierItems[index].id;
    } else if (cashierItems.length > index - 1) {
      currentCashierTabId = cashierItems[index - 1].id;
    }
    notifyListeners();
  }

  resetForm() {
    formGroup.reset();
  }

  saveCashierSession() async {
    saving = true;
    notifyListeners();
    try {
      await cashierSessionRepo.insert(CashierSessionInsertModel(
        branchId: AppState().global.currentBranch!.id,
        dateOpen: DateTime.now().toUtc(),
        machineId: 0,
        openValue: moneyValue(fgOpenValue.value ?? '0'),
        note: '',
        userId: AppState().authState.user!.id,
      ));
      currentSession = await cashierSessionRepo.getActive();
      cashierOpened = true;
      setUpFirstCashierItem();
      saving = false;
      notifyListeners();
    } catch (e) {
      saving = false;
      notifyListeners();
      rethrow;
    }
  }

  loadReport() async {
    reportLoading = true;
    fgCloseValue.reset();
    notifyListeners();
    try {
      report = await cashierSessionRepo.getReport(currentSession!.id!);
      reportLoading = false;
      notifyListeners();
    } catch (e) {
      reportLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  closeSession() async {
    saving = true;
    notifyListeners();
    try {
      await cashierSessionRepo.close(
          currentSession!.id!, CashierSessionCloseModel(DateTime.now().toUtc(), moneyValue(fgCloseValue.value!)));
      currentSession = await cashierSessionRepo.get(currentSession!.id!);
      reportLoading = true;
      saving = false;
      notifyListeners();
    } catch (e) {
      saving = false;
      notifyListeners();
      rethrow;
    }
  }

  reset() {
    cashierOpened = false;
    cashierItems.clear();
    notifyListeners();
  }
}
