import 'package:flutter/material.dart';
import 'package:sultanpos/http/httpapi.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/error.dart';
import 'package:sultanpos/model/listresult.dart';

class ListState<T extends BaseModel> extends ChangeNotifier {
  final HttpAPI httpAPI;
  final String path;
  final T Function(Map<String, dynamic> json) creator;
  int page = 0;
  int rowPerPage;
  ListBase state = ListNone();

  ListState(this.httpAPI, this.path, this.creator, {this.rowPerPage = 50});

  load({int page = -1}) async {
    if (state is ListLoading) return;
    if (page >= 0) this.page = page;
    state = ListLoading();
    notifyListeners();
    try {
      state = await httpAPI.query(path, fromJsonFunc: creator, limit: rowPerPage, offset: page * rowPerPage);
    } on ErrorResponse catch (e) {
      debugPrint(e.toJson().toString());
      state = ListError(e.message);
    }
    notifyListeners();
  }
}
