import 'package:intl/intl.dart';

extension IntX on int? {
  String getPriceStandardFormat() {
    if (this == null) {
      return "-";
    }

    return NumberFormat('###,###,###').format(this);
  }
}
