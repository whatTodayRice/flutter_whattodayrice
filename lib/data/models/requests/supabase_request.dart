class SupabaseRequest {
  final String? table;
  final List<String>? columns;
  final List<String>? columnValue;
  final Map<String, dynamic>? data;
  final List<String>? orderBy;
  final bool? isAscending;
  final int? limit;
  final int? offSet;
  final String? function;
  final Map<String, dynamic>? params;

  SupabaseRequest({
    this.table,
    this.columns,
    this.columnValue,
    this.data,
    this.orderBy,
    this.isAscending,
    this.limit,
    this.offSet,
    this.function,
    this.params,
  });
}
