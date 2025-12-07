import 'package:intl/intl.dart';

class Formatters {
  static String formatDate(DateTime date) {
    return DateFormat("dd MMM yyyy").format(date);
  }

  static String formatCurrency(num amount) {
    final formatter = NumberFormat.currency(locale: "id_ID", symbol: "Rp");
    return formatter.format(amount);
  }
}