import 'package:flutter/services.dart';
import 'package:flutter_whattodayrice/utils/extensions/int_extension.dart';

class NumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    String value = newValue.text.replaceAll(',', '');

    if (int.tryParse(value) == null) {
      return oldValue;
    }

    final formattedValue = int.parse(value).getPriceStandardFormat();

    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}
