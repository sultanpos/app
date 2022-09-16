import 'package:sultanpos/model/base.dart';

class ListBase {}

class ListNone extends ListBase {}

class ListLoading extends ListBase {}

class ListError extends ListBase {
  String error;
  ListError(this.error);
}

class ListResult<T extends BaseModel> extends ListBase {
  final List<T> data;
  final int total;

  ListResult(this.data, this.total);

  factory ListResult.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic> json) creator) {
    return ListResult((json['data'] as List).map((e) => creator(e)).toList(), json['total'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => e.toJson()),
      'total': total,
    };
  }
}
