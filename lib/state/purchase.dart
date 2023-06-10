import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/purchase.dart';
import 'package:sultanpos/repository/repository.dart';
import 'package:sultanpos/repository/restrepository.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/crud.dart';
import 'package:sultanpos/state/purchaseitem.dart';

class PurchaseTabItem {
  final String id;
  final String title;
  PurchaseTabItem(this.id, this.title);
}

class PurchaseState extends CrudStateWithList<PurchaseModel> {
  final BaseCRUDRepository<PurchaseItemModel> itemRepo;
  final fgRefNumber = FormControl<String>();
  final fgPartnerId = FormControl<int>(validators: [Validators.required], touched: false);
  final fgDate = FormControl<DateTime>(validators: [Validators.required], touched: false);
  final fgDeadline = FormControl<DateTime>();

  PurchaseState({required super.repo, required this.itemRepo}) {
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
    items.add(PurchaseItemState(repo: itemRepo, purchase: value));
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
    final defaultBranch = AppState().shareState.defaultBranch();
    final now = DateTime.now().add(const Duration(days: 7));
    return PurchaseInsertModel(
      fgDate.value!.toUtc(),
      defaultBranch?.id ?? 0,
      fgPartnerId.value ?? 0,
      fgRefNumber.value ?? '',
      'normal',
      fgDeadline.value?.toUtc() ?? DateTime(now.year, now.month, now.day).toUtc(),
    );
  }

  @override
  BaseModel prepareUpdateModel() {
    final defaultBranch = AppState().shareState.defaultBranch();
    final now = DateTime.now().add(const Duration(days: 7));
    return PurchaseUpdateModel(
      fgDate.value!.toUtc(),
      defaultBranch?.id ?? 0,
      fgPartnerId.value ?? 0,
      fgRefNumber.value ?? '',
      fgDeadline.value?.toUtc() ?? DateTime(now.year, now.month, now.day).toUtc(),
    );
  }
}
