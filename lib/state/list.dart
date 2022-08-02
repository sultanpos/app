import 'package:flutter/material.dart';
import 'package:sultanpos/http/httpapi.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/error.dart';
import 'package:sultanpos/model/listresult.dart';

class ListState<T extends BaseModel> extends ChangeNotifier {
  final HttpAPI httpAPI;
  final String path;
  final T Function(Map<String, dynamic> json) creator;
  int offset = 0;
  int limit = 100;
  ListBase state = ListLoading();

  ListState(this.httpAPI, this.path, this.creator);

  load() async {
    state = ListLoading();
    notifyListeners();
    try {
      state = await httpAPI.query(path, fromJsonFunc: creator, limit: limit, offset: offset);
    } on ErrorResponse catch (e) {
      debugPrint(e.toJson().toString());
      state = ListError(e.message);
    }
    notifyListeners();
  }
}
