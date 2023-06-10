import 'package:flutter/material.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/error.dart';
import 'package:sultanpos/model/listresult.dart';
import 'package:sultanpos/repository/repository.dart';
import 'package:sultanpos/repository/rest/restrepository.dart';

abstract class ListBaseState<T extends BaseModel> extends ChangeNotifier {
  final BaseCRUDRepository<T> repo;
  int page = 0;
  int rowPerPage;
  ListBase state = ListNone();
  int _cachedTotalPage = 0;

  ListBaseState({required this.repo, this.rowPerPage = 50});

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

class HttpListState<T extends BaseModel> extends ListBaseState<T> {
  HttpListState({required super.repo});

  @override
  doLoad() async {
    try {
      //state = await httpAPI.query(path, fromJsonFunc: creator, limit: rowPerPage, offset: page * rowPerPage);
      state = await repo.query(RestFilterModel(limit: rowPerPage, offset: page * rowPerPage));
    } on ErrorResponse catch (e) {
      debugPrint(e.toJson().toString());
      state = ListError(e.message);
    }
    notifyListeners();
  }
}
