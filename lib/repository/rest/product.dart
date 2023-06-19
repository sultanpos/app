import 'package:sultanpos/model/product.dart';
import 'package:sultanpos/repository/repository.dart';
import 'package:sultanpos/repository/rest/restrepository.dart';

class RestProductRepo extends BaseRestCRUDRepository<ProductModel> implements ProductRepository {
  RestProductRepo({required super.httpApi}) : super(creator: ProductModel.fromJson, path: '/product');

  @override
  Future getByBarcode(String barcode) {
    // TODO: implement getByBarcode
    throw UnimplementedError();
  }

  @override
  Future queryByName(String name) {
    // TODO: implement queryByName
    throw UnimplementedError();
  }
}
