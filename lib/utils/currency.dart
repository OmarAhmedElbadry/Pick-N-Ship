import 'package:intl/intl.dart';

String formatEgp(num amount, {int decimalDigits = 0}) => NumberFormat.currency(
  locale: 'en_EG',
  name: 'EGP',
  symbol: 'EGP ',
  decimalDigits: decimalDigits,
).format(amount);
