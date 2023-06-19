import 'package:flutter/material.dart';
import 'package:sultanpos/model/cashier.dart';
import 'package:sultanpos/repository/repository.dart';

class CashierRootState extends ChangeNotifier {
  final ProductRepository productRepo;
  final CashierSessionRepository cashierSessionRepo;

  bool loadingInit = true;
  CashierSessionModel? currentSession;
  bool cashierOpened = false;

  CashierRootState({required this.productRepo, required this.cashierSessionRepo});

  init() async {
    try {
      currentSession = await cashierSessionRepo.getActive();
      if (currentSession != null) {
        cashierOpened = true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    loadingInit = false;
    notifyListeners();
  }

  openCashierWithoutSession() {
    cashierOpened = true;
    notifyListeners();
  }
}
