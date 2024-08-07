import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/listresult.dart';
import 'package:sultanpos/state/list.dart';

class ListWidget<T extends BaseModel> extends StatelessWidget {
  final HttpListState<T> listState;
  final Widget Function(BuildContext context, T value) builder;
  const ListWidget(this.listState, {required this.builder, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HttpListState>.value(
      value: listState,
      child: Builder(
        builder: (ctx) {
          final state = ctx.select<HttpListState, ListBase>((value) => value.state);
          if (state is ListLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ListError) {
            return Center(
              child: Text(state.error),
            );
          }
          if (state is ListResult) {
            return ListView.separated(
              itemBuilder: (c, i) {
                final data = state.data[i] as T;
                return builder(ctx, data);
              },
              separatorBuilder: (c, i) => const Divider(
                height: 0,
              ),
              itemCount: state.data.length,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
