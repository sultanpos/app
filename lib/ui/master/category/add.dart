import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/category.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/category.dart';
import 'package:sultanpos/ui/theme.dart';
import 'package:sultanpos/ui/util/textformatter.dart';
import 'package:sultanpos/ui/widget/basewindow.dart';
import 'package:sultanpos/ui/widget/button.dart';
import 'package:sultanpos/ui/widget/dropdown.dart';
import 'package:sultanpos/ui/widget/labelfield.dart';
import 'package:sultanpos/ui/widget/showerror.dart';

class CategoryAddWidget extends StatelessWidget {
  final String title;
  const CategoryAddWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWindowWidget(
      title: title,
      icon: Icons.account_tree,
      height: 500,
      width: 350,
      child: ChangeNotifierProvider.value(
        value: AppState().categoryState,
        child: Builder(
          builder: (ctx) {
            final loading = ctx.select<CategoryState, bool>((value) => value.loading);
            return ReactiveForm(
              formGroup: AppState().categoryState.form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        const LabelField('Parent Kategori'),
                        DropdownRepo<CategoryModel, int>(
                          creator: CategoryModel.fromJson,
                          path: "/category",
                          formControlName: 'parent_id',
                          autoFocus: true,
                          textFn: (value) => value.name,
                          valueFn: (value) => value.id,
                          decoration: const InputDecoration(
                            hintText: "Pilih parent",
                          ),
                        ),
                        SizedBox(
                          height: STheme().widgetSpace,
                        ),
                        const LabelField('Nama Kategori'),
                        ReactiveTextField(
                          formControlName: 'name',
                          inputFormatters: [UpperCaseTextFormatter()],
                          decoration: const InputDecoration(
                            hintText: "Masukkan nama kategori",
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: STheme().widgetSpace,
                        ),
                        const LabelField('Kode'),
                        ReactiveTextField(
                          formControlName: 'code',
                          inputFormatters: [UpperCaseTextFormatter()],
                          decoration: const InputDecoration(
                            hintText: "Masukkan code",
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: STheme().widgetSpace,
                        ),
                        const LabelField('Keterangan'),
                        ReactiveTextField(
                          formControlName: 'description',
                          decoration: const InputDecoration(
                            hintText: "Masukkan keterangan",
                          ),
                          onSubmitted: (c) => save(ctx),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SButton(
                          positive: false,
                          label: "Batal",
                          onPressed: loading
                              ? null
                              : () {
                                  Navigator.of(ctx).pop();
                                },
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: SButton(
                          label: "Simpan",
                          onPressed: loading
                              ? null
                              : () async {
                                  save(ctx);
                                },
                        ),
                      ),
                    ],
                  ),
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
