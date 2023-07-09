import 'package:sultanpos/model/sale.dart';
import 'package:sultanpos/repository/repository.dart';
import 'package:sultanpos/repository/rest/restrepository.dart';

class RestSaleRepo extends BaseRestCRUDRepository<SaleModel> implements SaleRepository {
  RestSaleRepo({required super.httpApi}) : super(path: '/sale', creator: SaleModel.fromJson);

  @override
  Future insertCashier(SaleCashierInsertModel data) async {
    return httpApi.post(data, '/sale/cashier');
  }
}
