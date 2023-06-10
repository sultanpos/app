import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/error.dart';
import 'package:sultanpos/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:sultanpos/state/list.dart';

abstract class CrudState<T extends BaseModel> extends ChangeNotifier {
  final BaseCRUDRepository<T> repo;

  bool loading = false;
  T? current;
  late FormGroup form;

  CrudState({required this.repo});

  resetForm() {
    form.reset();
    form.markAsUntouched();
    current = null;
  }

  editForm(T value) {
    prepareEditForm(value);
    form.markAllAsTouched();
    current = value;
  }

  prepareEditForm(T value);

  BaseModel prepareInsertModel();
  BaseModel prepareUpdateModel();

  save() async {
    if (!form.valid) throw 'form tidak valid';
    loading = true;
    notifyListeners();
    try {
      if (current == null) {
        await repo.insert(prepareInsertModel());
      } else {
        await repo.update((current as BaseModel).getId(), prepareUpdateModel());
      }
      loading = false;
      notifyListeners();
      afterSaveSuccess();
    } on ErrorResponse catch (e) {
      loading = false;
      notifyListeners();
      throw e.message;
    } catch (e) {
      loading = false;
      notifyListeners();
      throw e.toString();
    }
  }

  remove(int id) async {
    try {
      await repo.delete(id);
      afterRemoveSuccess();
    } on ErrorResponse catch (e) {
      throw e.message;
    }
  }

  afterSaveSuccess() {}
  afterRemoveSuccess() {}
}

abstract class CrudStateWithList<T extends BaseModel> extends CrudState<T> {
  HttpListState<T> listData;

  CrudStateWithList({required super.repo}) : listData = HttpListState<T>(repo: repo);

  @override
  afterSaveSuccess() {
    listData.load(refresh: true);
  }

  @override
  afterRemoveSuccess() {
    listData.load(refresh: true);
  }
}
