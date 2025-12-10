import 'package:flutter/material.dart';
import '../models/booking_model.dart';
import '../services/booking_service.dart';

class BookingViewModel extends ChangeNotifier {
  final BookingService _service = BookingService();

  bool isLoading = false;
  String errorMessage = '';

  Future<void> createBooking(BookingModel booking) async {
    try {
      isLoading = true;
      notifyListeners();

      await _service.createBooking(booking);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Stream<List<BookingModel>> getBookings(String tripId) {
    return _service.getBookingsByTrip(tripId);
  }

  Future<void> updateStatus(
    String tripId,
    String bookingId,
    String status,
  ) async {
    await _service.updateBookingStatus(tripId, bookingId, status);
    notifyListeners();
  }

  // supaya UI bisa akses detail booking
  Future<BookingModel?> getBookingDetail(String tripId, String bookingId) {
    return _service.getBookingDetail(tripId, bookingId);
  }
}
