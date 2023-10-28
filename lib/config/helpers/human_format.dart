import 'package:intl/intl.dart';

class HumanFormat {
  static String format(double number, [ int fractionDigits = 2 ]) {
    final formatNumber = NumberFormat.compactCurrency(
      decimalDigits: fractionDigits,
      locale: 'en',
      symbol: '',
    ).format(number);
    return formatNumber;
  }
}
