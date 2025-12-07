class Logger {
  static void d(String message) {
    // debug log
    // ignore: avoid_print
    print("[DEBUG] $message");
  }

  static void e(String message) {
    // error log
    // ignore: avoid_print
    print("[ERROR] $message");
  }
}