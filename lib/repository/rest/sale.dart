import 'package:sultanpos/model/listresult.dart';
import 'package:sultanpos/model/payment.dart';
import 'package:sultanpos/model/sale.dart';
import 'package:sultanpos/repository/repository.dart';
import 'package:sultanpos/repository/rest/restrepository.dart';

class RestSaleRepo extends BaseRestCRUDRepository<SaleModel> implements SaleRepository {
  RestSaleRepo({required super.httpApi}) : super(path: '/sale', creator: SaleModel.fromJson);

  @override
  Future insertCashier(SaleCashierInsertModel data) async {
    return httpApi.post(data, '/sale/cashier');
  }

  @override
  Future<ListResult<SaleItemModel>> items(int saleId) {
    return httpApi.query(
      '/sale/$saleId/item',
      fromJsonFunc: SaleItemModel.fromJson,
      limit: -1,
      offset: 0,
      queryParameters: {},
    );
  }

  @override
  Future<ListResult<PaymentModel>> payments(int saleId) {
    return httpApi.query(
      '/sale/$saleId/payment',
      fromJsonFunc: PaymentModel.fromJson,
      limit: -1,
      offset: 0,
      queryParameters: {},
    );
  }
}
