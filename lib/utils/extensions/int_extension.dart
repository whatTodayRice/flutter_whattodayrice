import 'package:intl/intl.dart';

extension IntX on int {
  String getPriceStandardFormat() => NumberFormat('###,###,###').format(this);
}
