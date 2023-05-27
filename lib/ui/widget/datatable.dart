import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/listresult.dart';
import 'package:sultanpos/preference.dart';
import 'package:sultanpos/state/list.dart';
import 'package:sultanpos/util/color.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class SDataSource<T extends BaseModel> extends DataGridSource {
  List<SDataColumn<T>> columns;
  List<T>? data;
  BuildContext context;
  SDataSource(this.columns, this.context);

  @override
  List<DataGridRow> get rows => data == null
      ? []
      : data!.map((e) {
          return DataGridRow(
              cells: columns
                  .map((col) => DataGridCell<T>(
                        columnName: col.id,
                        value: e,
                      ))
                  .toList());
        }).toList();

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      final col = columns.firstWhere((element) => element.id == dataGridCell.columnName);
      if (col.getWidget != null) return col.getWidget!(dataGridCell.value);
      return Container(
        alignment: col.align,
        padding: const EdgeInsets.all(4.0),
        child: Text(
          col.get!(dataGridCell.value),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12),
        ),
      );
    }).toList());
  }

  loadNewData(List<T> data) {
    this.data = data;
    notifyListeners();
  }
}

class SDataColumn<T extends BaseModel> {
  final String id;
  final String title;
  final String Function(T v)? get;
  final Widget Function(T v)? getWidget;
  final double? width;
  final Alignment align;
  SDataColumn({required this.id, required this.title, this.get, this.getWidget, this.width, this.align = Alignment.centerLeft});
}

class SDataTable<T extends BaseModel> extends StatefulWidget {
  final String name;
  final ListHttpState<T> state;
  final List<SDataColumn<T>> columns;
  final void Function(T value)? onDoubleClicked;
  const SDataTable({required this.name, required this.state, required this.columns, this.onDoubleClicked, Key? key}) : super(key: key);

  @override
  State<SDataTable<T>> createState() => _SDataTableState<T>();
}

class _SDataTableState<T extends BaseModel> extends State<SDataTable<T>> {
  late Map<String, double> columnSize;
  late SDataSource<T> source;

  @override
  void initState() {
    super.initState();
    columnSize = Preference().getTableWidth(widget.name);
    if (columnSize.isEmpty) {
      for (var element in widget.columns) {
        columnSize[element.id] = element.width ?? 200;
      }
    }
    for (var element in widget.columns) {
      if (!columnSize.containsKey(element.id)) columnSize[element.id] = element.width ?? 200;
    }
    source = SDataSource<T>(widget.columns, context);
    Future.microtask(() {
      widget.state.addListener(stateListener);
      if (widget.state.state is ListResult) {
        stateListener();
      } else {
        widget.state.load();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.state.removeListener(stateListener);
  }

  stateListener() {
    if (widget.state.state is ListResult) {
      final data = (widget.state.state as ListResult<T>).data;
      source.loadNewData(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ListHttpState>.value(
      value: widget.state,
      child: Builder(builder: (ctx) {
        final state = ctx.watch<ListHttpState>();
        final list = state.state;
        return Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(border: Border.all(color: Theme.of(context).dividerColor)),
                child: Stack(
                  children: [
                    SfDataGrid(
                      source: source,
                      columns: widget.columns
                          .map(
                            (e) => GridColumn(
                              columnName: e.id,
                              columnWidthMode: e.width != null ? ColumnWidthMode.auto : ColumnWidthMode.none,
                              width: columnSize[e.id]!,
                              allowEditing: false,
                              label: Container(
                                color: lighterOrDarkerColor(Theme.of(context), Theme.of(context).scaffoldBackgroundColor),
                                alignment: Alignment.center,
                                child: Text(
                                  e.title,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      selectionMode: SelectionMode.single,
                      onCellDoubleTap: (details) {
                        final index = details.rowColumnIndex.rowIndex - 1;
                        if (widget.onDoubleClicked != null && index >= 0) {
                          final data = (list as ListResult).data;
                          widget.onDoubleClicked!(data[index] as T);
                        }
                      },
                      navigationMode: GridNavigationMode.row,
                      allowSorting: false,
                      isScrollbarAlwaysShown: true,
                      highlightRowOnHover: true,
                      gridLinesVisibility: GridLinesVisibility.both,
                      headerGridLinesVisibility: GridLinesVisibility.both,
                      allowColumnsResizing: true,
                      columnResizeMode: ColumnResizeMode.onResizeEnd,
                      onColumnResizeUpdate: (details) {
                        columnSize[details.column.columnName] = details.width;
                        Preference().saveTableWidth(widget.name, columnSize);
                        setState(() {});
                        return true;
                      },
                      rowHeight: 30,
                      headerRowHeight: 30,
                    ),
                    if (list is ListLoading)
                      const BlurryContainer(
                        child: SizedBox.expand(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    if (list is ListError)
                      BlurryContainer(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Error memuat data: ${list.error}'),
                              const SizedBox(
                                height: 16,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    widget.state.load();
                                  },
                                  child: const Text('Muat Ulang'))
                            ],
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Expanded(child: SizedBox()),
                DropdownButton<int>(
                  value: state.rowPerPage,
                  items: const [
                    DropdownMenuItem(
                      value: 5,
                      child: Text("5 per halaman"),
                    ),
                    DropdownMenuItem(
                      value: 25,
                      child: Text("25 per halaman"),
                    ),
                    DropdownMenuItem(
                      value: 50,
                      child: Text("50 per halaman"),
                    ),
                    DropdownMenuItem(
                      value: 100,
                      child: Text("100 per halaman"),
                    ),
                  ],
                  onChanged: (val) {
                    state.setRowPerPage(val!);
                  },
                ),
                const SizedBox(
                  width: 8,
                ),
                SizedBox(
                  width: 30,
                  child: ElevatedButton(
                    onPressed: state.page > 0
                        ? () {
                            if (list is ListResult) state.prevPage();
                          }
                        : null,
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(0)),
                    child: const Icon(
                      Icons.navigate_before,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text("${state.page + 1} / ${state.totalPage()}"),
                const SizedBox(
                  width: 8,
                ),
                SizedBox(
                  width: 30,
                  child: ElevatedButton(
                    onPressed: state.enableNext()
                        ? () {
                            if (list is ListResult) state.nextPage();
                          }
                        : null,
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(0)),
                    child: const Icon(
                      Icons.navigate_next,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
