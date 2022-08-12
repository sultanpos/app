import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/category.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/category.dart';
import 'package:sultanpos/ui/util/uppercaseformatter.dart';
import 'package:sultanpos/ui/widget/dropdown.dart';
import 'package:sultanpos/ui/widget/showerror.dart';

class CategoryAddWidget extends StatelessWidget {
  final String title;
  const CategoryAddWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: AppState().categoryState,
      child: Dialog(
        child: Builder(
          builder: (ctx) {
            final loading = ctx.select<CategoryState, bool>((value) => value.loading);
            return SizedBox(
              height: 400,
              width: 400,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ReactiveForm(
                  formGroup: AppState().categoryState.form,
                  child: Column(
                    children: [
                      Text(title),
                      const Divider(),
                      DropdownRepo<CategoryModel, String>(
                        creator: CategoryModel.fromJson,
                        path: "/category",
                        formControlName: 'parent_public_id',
                        autoFocus: true,
                        textFn: (value) => value.name,
                        valueFn: (value) => value.publicId,
                      ),
                      ReactiveTextField(
                        formControlName: 'name',
                        inputFormatters: [UpperCaseTextFormatter()],
                        decoration: const InputDecoration(
                          hintText: "Masukkan nama kategori",
                          labelText: "Nama Kategori",
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                      ReactiveTextField(
                        formControlName: 'code',
                        inputFormatters: [UpperCaseTextFormatter()],
                        decoration: const InputDecoration(
                          hintText: "Masukkan code",
                          labelText: "Code",
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                      ReactiveTextField(
                        formControlName: 'description',
                        decoration: const InputDecoration(
                          hintText: "Masukkan keterangan",
                          labelText: "Keterangan",
                        ),
                        onSubmitted: () => save(ctx),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: loading
                                  ? null
                                  : () {
                                      Navigator.of(ctx).pop();
                                    },
                              child: const Text("Batal")),
                          const SizedBox(
                            width: 8,
                          ),
                          ElevatedButton(
                              onPressed: loading
                                  ? null
                                  : () async {
                                      save(ctx);
                                    },
                              child: Text(loading ? "Menyimpan..." : "Simpan")),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  save(BuildContext ctx) async {
    try {
      final nav = Navigator.of(ctx);
      await AppState().categoryState.save();
      nav.pop();
    } catch (e) {
      showError(ctx, title: 'Error menyimpan', message: e.toString());
    }
  }
}
