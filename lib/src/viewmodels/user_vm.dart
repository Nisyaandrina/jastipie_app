import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';

class UserVM extends ChangeNotifier {
  final UserService _service = UserService();

  UserModel? user;
  bool _loading = false;
  bool get loading => _loading;

  /// SETTER LOADING
  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  /// LOAD USER BY ID
  Future<void> loadUser(String userId) async {
    _setLoading(true);

    user = await _service.getUserById(userId);

    _setLoading(false);
  }

  /// UPDATE PROFILE
  Future<bool> updateProfile({
    required String name,
    required String email,
  }) async {
    if (user == null) return false;

    _setLoading(true);

    try {
      await _service.updateProfile(user!.id, {
        'name': name,
        'email': email,
      });

      /// Update local model data
      user = user!.copyWith(
        name: name,
        email: email,
        updatedAt: DateTime.now(),
      );

      notifyListeners();
      return true;
    } catch (e) {
      debugPrint("Error updating profile: $e");
      return false;
    } finally {
      _setLoading(false);
    }
  }
}
