import 'package:flutter/material.dart';
import 'package:jastipie_app/src/models/request_model.dart';
import 'package:jastipie_app/src/services/request_service.dart';
import 'package:jastipie_app/src/services/auth_service.dart';

class RequestViewModel extends ChangeNotifier {
  final RequestService _requestService = RequestService();
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Stream<List<RequestModel>> get requestsStream =>
      _requestService.getRequests();

  Future<bool> addRequest({
    required String itemName,
    required String category,
    required double priceEst,
    required double weight,
    required String note,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final user = _authService.currentUser;
      if (user == null) throw Exception("User belum login");

      final newRequest = RequestModel(
        id: '',
        penitipId: user.uid,
        itemName: itemName,
        category: category,
        priceEst: priceEst,
        weight: weight,
        note: note,
        status: 'PENDING',
        createdAt: DateTime.now(),
      );

      await _requestService.createRequest(newRequest);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> updateStatus(String id, String status) async {
    try {
      await _requestService.updateStatus(id, status);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> deleteRequest(String id) async {
    try {
      await _requestService.deleteRequest(id);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
