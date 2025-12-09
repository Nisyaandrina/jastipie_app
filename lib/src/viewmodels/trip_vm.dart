import 'package:flutter/material.dart';
import '../models/trip_model.dart';
import '../services/trip_service.dart';

class TripViewModel extends ChangeNotifier {
  final TripService _tripService = TripService();

  /// State
  bool isLoading = false;
  List<TripModel> trips = [];
  TripModel? tripDetail;

  /// LOADING HANDLER
  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  /// FETCH ALL TRIPS
  Future<void> fetchTrips() async {
    _setLoading(true);
    try {
      trips = await _tripService.getTrips();
    } catch (e) {
      debugPrint("Error fetching trips: $e");
    } finally {
      _setLoading(false);
    }
  }

  /// FETCH TRIP DETAIL
  Future<void> fetchTripDetail(String tripId) async {
    _setLoading(true);
    try {
      tripDetail = await _tripService.getTripById(tripId);
    } catch (e) {
      debugPrint("Error fetching trip detail: $e");
    } finally {
      _setLoading(false);
    }
  }

  /// CREATE TRIP
  Future<bool> createTrip(TripModel trip) async {
    _setLoading(true);
    try {
      await _tripService.createTrip(trip);
      await fetchTrips(); // reload list setelah create
      return true;
    } catch (e) {
      debugPrint("Error creating trip: $e");
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// UPDATE TRIP
  Future<bool> updateTrip(String tripId, Map<String, dynamic> data) async {
    _setLoading(true);
    try {
      await _tripService.updateTrip(tripId, data);
      await fetchTrips();
      return true;
    } catch (e) {
      debugPrint("Error updating trip: $e");
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// CLOSE TRIP (Untuk integrasi booking)
  Future<bool> closeTrip(String tripId) async {
    _setLoading(true);
    try {
      await _tripService.closeTrip(tripId);
      await fetchTrips();
      return true;
    } catch (e) {
      debugPrint("Error closing trip: $e");
      return false;
    } finally {
      _setLoading(false);
    }
  }
}
