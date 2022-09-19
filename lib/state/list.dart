import 'package:flutter/material.dart';
import 'package:sultanpos/http/httpapi.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/error.dart';
import 'package:sultanpos/model/listresult.dart';

abstract class ListBaseState<T extends BaseModel> extends ChangeNotifier {
  final T Function(Map<String, dynamic> json) creator;
  int page = 0;
  int rowPerPage;
  ListBase state = ListNone();
  int _cachedTotalPage = 0;

  ListBaseState(this.creator, {this.rowPerPage = 50});

  load({int page = -1, bool refresh = false}) async {
    if (state is ListLoading) return;
    if (!refresh && this.page == page) return;
    if (!refresh && state is ListResult) return;
    if (page >= 0) this.page = page;
    state = ListLoading();
    notifyListeners();
    doLoad();
  }

  setRowPerPage(int value) {
    rowPerPage = value;
    load(page: 0, refresh: true);
  }

  int totalPage() {
    if (state is ListResult<T>) {
      final total = (state as ListResult<T>).total ~/ rowPerPage;
      final mod = (state as ListResult<T>).total % rowPerPage;
      _cachedTotalPage = mod > 0 || total == 0 ? total + 1 : total;
    }
    return _cachedTotalPage;
  }

  bool enableNext() {
    int total = totalPage();
    if (total == 1) return false;
    return page < total - 1;
  }

  void prevPage() {
    page--;
    load(refresh: true);
  }

  void nextPage() {
    page++;
    load(refresh: true);
  }

  void doLoad();
}

class ListHttpState<T extends BaseModel> extends ListBaseState<T> {
  final HttpAPI httpAPI;
  final String path;

  ListHttpState(this.httpAPI, this.path, super.creator, {super.rowPerPage = 50});

  @override
  doLoad() async {
    try {
      state = await httpAPI.query(path, fromJsonFunc: creator, limit: rowPerPage, offset: page * rowPerPage);
    } on ErrorResponse catch (e) {
      debugPrint(e.toJson().toString());
      state = ListError(e.message);
    }
    notifyListeners();
  }
}

class ListIsarState<T extends BaseModel> extends ListBaseState<T> {
  ListIsarState(super.creator, {super.rowPerPage = 50});

  @override
  doLoad() async {
    notifyListeners();
  }
}
