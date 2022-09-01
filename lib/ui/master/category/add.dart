import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/category.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/category.dart';
import 'package:sultanpos/ui/theme.dart';
import 'package:sultanpos/ui/util/textformatter.dart';
import 'package:sultanpos/ui/widget/basewindow.dart';
import 'package:sultanpos/ui/widget/dropdown.dart';
import 'package:sultanpos/ui/widget/showerror.dart';

class CategoryAddWidget extends StatelessWidget {
  final String title;
  const CategoryAddWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWindowWidget(
      title: title,
      height: 400,
      width: 400,
      child: ChangeNotifierProvider.value(
        value: AppState().categoryState,
        child: Builder(
          builder: (ctx) {
            final loading = ctx.select<CategoryState, bool>((value) => value.loading);
            return ReactiveForm(
              formGroup: AppState().categoryState.form,
              child: Column(
                children: [
                  DropdownRepo<CategoryModel, String>(
                    creator: CategoryModel.fromJson,
                    path: "/category",
                    formControlName: 'parent_public_id',
                    autoFocus: true,
                    textFn: (value) => value.name,
                    valueFn: (value) => value.publicId,
                    decoration: const InputDecoration(
                      hintText: "Pilih parent",
                      labelText: "Parent Kategori",
                    ),
                  ),
                  SizedBox(
                    height: STheme().widgetSpace,
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
                  SizedBox(
                    height: STheme().widgetSpace,
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
                  SizedBox(
                    height: STheme().widgetSpace,
                  ),
                  ReactiveTextField(
                    formControlName: 'description',
                    decoration: const InputDecoration(
                      hintText: "Masukkan keterangan",
                      labelText: "Keterangan",
                    ),
                    onSubmitted: (c) => save(ctx),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                          ),
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
