class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email tidak boleh kosong";
    }

    // Validasi email tanpa RegExp (aman untuk Dart SDK baru)
    final parsed = Uri.tryParse("mailto:$value");

    if (parsed == null || !parsed.path.contains("@")) {
      return "Format email tidak valid";
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password tidak boleh kosong";
    }
    if (value.length < 6) {
      return "Password minimal 6 karakter";
    }
    return null;
  }
}
