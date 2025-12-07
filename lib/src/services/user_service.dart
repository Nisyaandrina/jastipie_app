/// Service sederhana untuk mengelola data user.
/// Nanti bisa dihubungkan ke Firebase/Auth API sesuai kebutuhan.
class UserService {
  // Simulasi data user
  String _name = "Nisya";
  String _email = "nisya@example.com";

  String get name => _name;
  String get email => _email;

  /// Update profil user
  Future<void> updateProfile({required String name, required String email}) async {
    // TODO: sambungkan ke backend/Firebase
    await Future.delayed(const Duration(milliseconds: 500));
    _name = name;
    _email = email;
  }

  /// Logout user
  Future<void> logout() async {
    // TODO: implementasi logout (FirebaseAuth.instance.signOut())
    await Future.delayed(const Duration(milliseconds: 500));
  }
}