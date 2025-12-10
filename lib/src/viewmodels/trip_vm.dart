import 'package:flutter/material.dart';
import '../models/trip_model.dart';
import '../services/trip_service.dart';

class TripViewModel extends ChangeNotifier {
  final TripService _tripService = TripService();

  bool isLoading = false;
  bool isLoaded = false; // <-- tambah field ini
  List<TripModel> trips = [];
  TripModel? tripDetail;

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  /// FETCH ALL TRIPS
  Future<void> fetchTrips() async {
    // if already loaded and you want to force refresh, you can skip this check
    // if (isLoaded) return;
    _setLoading(true);
    try {
      trips = await _tripService.getTrips();
      isLoaded = true; // tandai sudah di-load
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetchTrips: $e");
    } finally {
      _setLoading(false);
    }
  }

  /// FETCH TRIP DETAIL
  Future<void> fetchTripDetail(String id) async {
    _setLoading(true);
    try {
      tripDetail = await _tripService.getTripById(id);
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetchTripDetail: $e");
    } finally {
      _setLoading(false);
    }
  }

  /// CREATE TRIP (mengembalikan bool untuk kompatibilitas UI)
  Future<bool> createTrip(TripModel trip) async {
    _setLoading(true);
    try {
      final createdId = await _tripService.createTrip(trip);
      // optional: you can fetch the created doc if you want to have the model with id
      await fetchTrips(); // reload list setelah create
      return createdId.isNotEmpty;
    } catch (e) {
      debugPrint("Error createTrip: $e");
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// UPDATE TRIP
  Future<bool> updateTrip(String id, Map<String, dynamic> data) async {
    _setLoading(true);
    try {
      await _tripService.updateTrip(id, data);
      await fetchTrips();
      return true;
    } catch (e) {
      debugPrint("Error updateTrip: $e");
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// CLOSE TRIP
  Future<bool> closeTrip(String id) async {
    _setLoading(true);
    try {
      await _tripService.closeTrip(id);
      await fetchTrips();
      return true;
    } catch (e) {
      debugPrint("Error closeTrip: $e");
      return false;
    } finally {
      _setLoading(false);
    }
  }
}
