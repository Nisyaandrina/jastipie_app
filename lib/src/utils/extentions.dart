extension StringExtensions on String {
  bool get isValidEmail {
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return regex.hasMatch(this);
  }
}

extension DateTimeExtensions on DateTime {
  String get formatted => "${day.toString().padLeft(2, '0')}-${month.toString().padLeft(2, '0')}-${year}";
}