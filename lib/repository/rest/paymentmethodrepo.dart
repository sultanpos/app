import 'package:sultanpos/model/paymentmethod.dart';
import 'package:sultanpos/repository/repository.dart';
import 'package:sultanpos/repository/rest/restrepository.dart';

class RestPaymentMethodRepo extends BaseRestCRUDRepository<PaymentMethodModel> implements PaymentMethodRepository {
  RestPaymentMethodRepo({required super.httpApi}) : super(creator: PaymentMethodModel.fromJson, path: '/paymentmethod');

  PaymentMethodModel? defMethod;
  @override
  Future<PaymentMethodModel> getDefaultCashMethod() async {
    if (defMethod != null) {
      return defMethod!;
    }
    try {
      final method = await httpApi.getOne('$path/default', fromJsonFunc: creator);
      defMethod = method;
      return defMethod!;
    } catch (e) {
      rethrow;
    }
  }
}
