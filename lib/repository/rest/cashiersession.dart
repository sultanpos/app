import 'package:sultanpos/model/cashier.dart';
import 'package:sultanpos/repository/repository.dart';
import 'package:sultanpos/repository/rest/restrepository.dart';

class RestCashierSessionRepo extends BaseRestCRUDRepository<CashierSessionModel> implements CashierSessionRepository {
  RestCashierSessionRepo({required super.httpApi})
      : super(creator: CashierSessionModel.fromJson, path: '/cashiersession');

  @override
  Future<CashierSessionModel> getActive() {
    return httpApi.getOne<CashierSessionModel>('$path/active', fromJsonFunc: CashierSessionModel.fromJson);
  }

  @override
  Future<CashierSessionReportModel> getReport(int id) async {
    return httpApi.getOne<CashierSessionReportModel>('$path/$id/report',
        fromJsonFunc: CashierSessionReportModel.fromJson);
  }

  @override
  Future close(int id, CashierSessionCloseModel data) {
    return httpApi.put(data, '$path/$id/close');
  }
}
