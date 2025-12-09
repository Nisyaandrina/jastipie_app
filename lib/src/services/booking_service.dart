import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/booking_model.dart';

class BookingService {
  final CollectionReference tripsRef =
      FirebaseFirestore.instance.collection('trips');

  Future<void> createBooking(BookingModel booking) async {
    await tripsRef
        .doc(booking.tripId)
        .collection('bookings')
        .doc(booking.bookingId)
        .set(booking.toMap());
  }

  Stream<List<BookingModel>> getBookingsByTrip(String tripId) {
    return tripsRef
        .doc(tripId)
        .collection('bookings')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => BookingModel.fromMap(doc.data()))
            .toList());
  }

  Future<BookingModel?> getBookingDetail(String tripId, String bookingId) async {
    final doc = await tripsRef
        .doc(tripId)
        .collection('bookings')
        .doc(bookingId)
        .get();

    if (!doc.exists) return null;

    return BookingModel.fromMap(doc.data()!);
  }

  Future<void> updateBookingStatus(
      String tripId, String bookingId, String status) async {
    await tripsRef
        .doc(tripId)
        .collection('bookings')
        .doc(bookingId)
        .update({'status': status});
  }
}
