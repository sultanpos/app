import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/model/listresult.dart';
import 'package:sultanpos/state/list.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class SDataSource<T> extends DataGridSource {
  List<SDataColumn<T>> columns;
  List<T>? data;
  SDataSource(this.columns);

  @override
  List<DataGridRow> get rows => data == null
      ? []
      : data!.map((e) {
          return DataGridRow(
              cells: columns
                  .map((col) => DataGridCell(
                        columnName: col.id,
                        value: col.get != null ? col.get!(e) : 'no value',
                      ))
                  .toList());
        }).toList();

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row
            .getCells()
            .asMap()
            .map<int, Widget>((index, dataGridCell) {
              final getWidget = columns.firstWhere((element) => element.id == dataGridCell.columnName);
              if (getWidget.getWidget != null) return MapEntry(index, getWidget.getWidget!(data![index]));
              return MapEntry(
                  index,
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(4.0),
                    child: Text(dataGridCell.value.toString()),
                  ));
            })
            .values
            .toList());
  }

  loadNewData(List<T> data) {
    this.data = data;
    notifyListeners();
  }
}

class SDataColumn<T> {
  final String id;
  final String title;
  final String Function(T v)? get;
  final Widget Function(T v)? getWidget;
  final double? width;
  SDataColumn({required this.id, required this.title, this.get, this.getWidget, this.width});
}

class SDataTable<T> extends StatefulWidget {
  final ListState state;
  final List<SDataColumn> columns;
  final void Function(T value)? onDoubleClicked;
  const SDataTable({required this.state, required this.columns, this.onDoubleClicked, Key? key}) : super(key: key);

  @override
  State<SDataTable<T>> createState() => _SDataTableState<T>();
}

class _SDataTableState<T> extends State<SDataTable<T>> {
  late SDataSource source;

  @override
  void initState() {
    super.initState();
    source = SDataSource(widget.columns);
    Future.microtask(() {
      widget.state.addListener(stateListener);
      widget.state.load();
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.state.removeListener(stateListener);
  }

  stateListener() {
    if (widget.state.state is ListResult) {
      source.loadNewData((widget.state.state as ListResult).data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ListState>.value(
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
                      child: Row(
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
                                columnName: e.title,
                                width: e.width ?? double.nan,
                                label: Center(
                                  child: Text(e.title),
                                ),
                              ))
                          .toList(),
                      selectionMode: SelectionMode.single,
                      onCellLongPress: (details) {
                        final index = details.rowColumnIndex.rowIndex - 1;
                        if (widget.onDoubleClicked != null && index >= 0) {
                          final data = (list as ListResult).data;
                          widget.onDoubleClicked!(data[index] as T);
                        }
                      },
                      navigationMode: GridNavigationMode.row,
                      allowSorting: true,
                      isScrollbarAlwaysShown: true,
                      highlightRowOnHover: true,
                    );
        },
      ),
    );
  }
}
