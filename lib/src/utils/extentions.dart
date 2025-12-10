extension StringExtensions on String {
  bool get isValidEmail {
    return Uri.tryParse("mailto:$this")?.path.contains("@") ?? false;
  }
}

extension DateTimeExtensions on DateTime {
  String get formatted =>
      "${day.toString().padLeft(2, '0')}-${month.toString().padLeft(2, '0')}-$year";
}
