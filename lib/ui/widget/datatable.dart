import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/listresult.dart';
import 'package:sultanpos/preference.dart';
import 'package:sultanpos/state/list.dart';
import 'package:sultanpos/ui/util/color.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class SDataSource<T extends BaseModel> extends DataGridSource {
  List<SDataColumn<T>> columns;
  List<T>? data;
  SDataSource(this.columns);

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
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(4.0),
        child: Text(col.get!(dataGridCell.value)),
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
  SDataColumn({required this.id, required this.title, this.get, this.getWidget, this.width});
}

class SDataTable<T extends BaseModel> extends StatefulWidget {
  final String name;
  final ListState<T> state;
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
    source = SDataSource<T>(widget.columns);
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
    Preference().saveTableWidth(widget.name, columnSize);
  }

  stateListener() {
    if (widget.state.state is ListResult) {
      final data = (widget.state.state as ListResult<T>).data;
      source.loadNewData(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Theme.of(context).dividerColor)),
      child: ChangeNotifierProvider<ListState>.value(
        value: widget.state,
        child: Builder(
          builder: (ctx) {
            final list = ctx.select<ListState, ListBase>((value) => value.state);
            return list is ListLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : list is ListError
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Error memuat data: ${list.error}'),
                            const SizedBox(
                              height: 16,
                            ),
                            IconButton(
                                onPressed: () {
                                  widget.state.load();
                                },
                                icon: const Icon(Icons.refresh))
                          ],
                        ),
                      )
                    : SfDataGrid(
                        source: source,
                        columns: widget.columns
                            .map((e) => GridColumn(
                                columnName: e.id,
                                columnWidthMode: e.width != null ? ColumnWidthMode.auto : ColumnWidthMode.none,
                                width: columnSize[e.id]!,
                                allowEditing: false,
                                label: Container(
                                  color: lighterOrDarkerColor(Theme.of(context), Theme.of(context).scaffoldBackgroundColor),
                                  alignment: Alignment.center,
                                  child: Text(e.title),
                                )))
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
                          setState(() {});
                          return true;
                        },
                        rowHeight: 40,
                        headerRowHeight: 40,
                      );
          },
        ),
      ),
    );
  }
}
