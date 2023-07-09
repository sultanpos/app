import 'package:flutter/material.dart';
import 'package:sultanpos/model/cashier.dart';
import 'package:sultanpos/repository/repository.dart';
import 'package:sultanpos/state/cart.dart';

class CashierRootState extends ChangeNotifier {
  final ProductRepository productRepo;
  final CashierSessionRepository cashierSessionRepo;
  final PaymentMethodRepository paymetnMethodRepo;
  final SaleRepository saleRepo;

  int cashierId = 0;
  bool loadingInit = true;
  CashierSessionModel? currentSession;
  bool cashierOpened = false;
  int currentCashierTabId = 0;

  late List<CartState> cashierItems;

  CashierRootState({
    required this.productRepo,
    required this.cashierSessionRepo,
    required this.paymetnMethodRepo,
    required this.saleRepo,
  });

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
    cashierItems = [
      CartState(
        cashierId++,
        productRepo: productRepo,
        paymentMethodRepo: paymetnMethodRepo,
        saleRepository: saleRepo,
      )
    ];
  }

  newTabCashier() {
    cashierItems.add(CartState(
      cashierId++,
      productRepo: productRepo,
      paymentMethodRepo: paymetnMethodRepo,
      saleRepository: saleRepo,
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
}
