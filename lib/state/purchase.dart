import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/purchase.dart';
import 'package:sultanpos/repository/repository.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/crud.dart';
import 'package:sultanpos/state/purchaseitem.dart';

class PurchaseTabItem {
  final String id;
  final String title;
  PurchaseTabItem(this.id, this.title);
}

class PurchaseState extends CrudStateWithList<PurchaseModel> {
  final PurchaseRepository purchaseRepo;
  final ProductRepository productRepo;
  final fgRefNumber = FormControl<String>();
  final fgPartnerId = FormControl<int>(validators: [Validators.required], touched: false);
  final fgDate = FormControl<DateTime>(validators: [Validators.required], touched: false);
  final fgDeadline = FormControl<DateTime>();

  PurchaseState({required this.purchaseRepo, required this.productRepo}) : super(repo: purchaseRepo) {
    form = FormGroup({
      'ref_number': fgRefNumber,
      'partner_id': fgPartnerId,
      'date': fgDate,
      'deadline': fgDeadline,
    });
  }

  int? currentId;
  List<PurchaseItemState> items = [];

  setCurrentId(int curId) {
    currentId = curId;
    notifyListeners();
  }

  getItemState(int id) {
    return items.firstWhere((element) => element.purchase.id == id);
  }

  closeTab(int id) {
    items = items.where((element) => element.purchase.id != id).toList();
    notifyListeners();
  }

  open(PurchaseModel value) {
    final index = items.indexWhere((element) => element.purchase.id == value.id);
    if (index >= 0) {
      currentId = value.id;
      notifyListeners();
      return;
    }
    items.add(
      PurchaseItemState(
        productRepo: productRepo,
        repo: purchaseRepo.createItemRepository(value.id),
        purchase: value,
        purchaseRepo: purchaseRepo,
      ),
    );
    currentId = value.id;
    notifyListeners();
  }

  @override
  prepareEditForm(PurchaseModel value) {
    fgDate.updateValue(value.date.toLocal());
    fgRefNumber.updateValue(value.refNumber);
    fgDeadline.updateValue(value.deadline.toLocal());
    fgPartnerId.updateValue(value.partnerId);
  }

  @override
  BaseModel prepareInsertModel() {
    final branch = AppState().global.currentBranch!;
    final now = DateTime.now().add(const Duration(days: 7));
    return PurchaseInsertModel(
      fgDate.value!.toUtc(),
      branch.id,
      fgPartnerId.value ?? 0,
      fgRefNumber.value ?? '',
      'normal',
      fgDeadline.value?.toUtc() ?? DateTime(now.year, now.month, now.day).toUtc(),
    );
  }

  @override
  BaseModel prepareUpdateModel() {
    final defaultBranch = AppState().global.currentBranch!;
    final now = DateTime.now().add(const Duration(days: 7));
    return PurchaseUpdateModel(
      fgDate.value!.toUtc(),
      defaultBranch.id,
      fgPartnerId.value ?? 0,
      fgRefNumber.value ?? '',
      fgDeadline.value?.toUtc() ?? DateTime(now.year, now.month, now.day).toUtc(),
    );
  }
}
