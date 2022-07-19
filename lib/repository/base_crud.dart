import 'package:sultanpos/http/fetch.dart';
import 'package:sultanpos/model/base.dart';

class BaseCRUD {
  final String path;
  final Fetch fetch;
  BaseCRUD({required this.path, required this.fetch});

  Future insert<T>(BaseModel data) async {
    final ret = await fetch.post(path, data: data.toJson());
    return data.responseFromJson(ret.data) as T;
  }

  Future update<T>(String publicID, BaseModel data) async {
    final ret = await fetch.put('$path/$publicID', data: data.toJson());
    return data.responseFromJson(ret.data) as T;
  }

  Future delete(String publicID) {
    return fetch.delete('$path/$publicID');
  }

  Future get<T>(String publicID, T Function(Map<String, dynamic> json) fromJson) async {
    final ret = await fetch.get('$path/$publicID');
    return fromJson(ret.data);
  }
}
