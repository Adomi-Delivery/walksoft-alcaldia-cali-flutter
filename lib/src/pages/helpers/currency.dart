import 'package:intl/intl.dart';

String formatCurrency(
    {String? name, int decimalDigits = 0, required double? number}) {
  // return NumberFormat.decimalPattern("eu").format(number);
  if (number == null) {
    return "0";
  }
  return NumberFormat.currency(
    name: "\$",
    decimalDigits: decimalDigits,
    locale: "eu",
    customPattern: '\u00a4#,###.#',
  ).format(number);
}
