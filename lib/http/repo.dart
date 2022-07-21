import 'package:sultanpos/http/fetch.dart';
import 'package:sultanpos/model/base.dart';

class BaseRepo {
  final Fetch fetch;
  BaseRepo({required this.fetch});

  Future post<T>(BaseModel data, {String? path}) async {
    final ret = await fetch.post(path ?? data.path(), data: data.toJson());
    return data.responseFromJson(ret.data) as T;
  }

  Future put<T>(String publicID, BaseModel data, {String? path}) async {
    final ret = await fetch.put('${path ?? data.path()}/$publicID', data: data.toJson());
    return data.responseFromJson(ret.data) as T;
  }

  Future delete(String publicID, {required String path}) {
    return fetch.delete('$path/$publicID');
  }

  Future get<T>(String publicID, {required T Function(Map<String, dynamic> json) fromJsonFunc, required String path}) async {
    final ret = await fetch.get('$path/$publicID');
    return fromJsonFunc(ret.data);
  }
}
