import 'package:flutter/material.dart';
import 'package:jastipie_app/src/services/user_service.dart';

/// ViewModel untuk menghubungkan UI dengan UserService.
/// Bisa dipakai dengan Provider/ChangeNotifier.
class UserVM extends ChangeNotifier {
  final UserService _service = UserService();

  String get name => _service.name;
  String get email => _service.email;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> updateProfile(String name, String email) async {
    _loading = true;
    notifyListeners();

    await _service.updateProfile(name: name, email: email);

    _loading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    _loading = true;
    notifyListeners();

    await _service.logout();

    _loading = false;
    notifyListeners();
  }
}