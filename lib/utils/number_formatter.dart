import 'package:intl/intl.dart';

String formatNumber(double number, String locale) {
  final format = NumberFormat("#,##0.00", locale);
  return format.format(number);
}
