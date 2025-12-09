import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/trip_model.dart';

class TripService {
  final CollectionReference tripsRef =
      FirebaseFirestore.instance.collection('trips');

  /// CREATE Trip
  Future<void> createTrip(TripModel trip) async {
    await tripsRef.doc(trip.id).set(trip.toJson());
  }

  /// GET ALL Trips
  Future<List<TripModel>> getTrips() async {
    final snapshot = await tripsRef.orderBy('createdAt', descending: true).get();

    return snapshot.docs
        .map((doc) => TripModel.fromJson(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  /// GET Trip by ID
  Future<TripModel?> getTripById(String tripId) async {
    final doc = await tripsRef.doc(tripId).get();

    if (!doc.exists) return null;

    return TripModel.fromJson(doc.data() as Map<String, dynamic>, doc.id);
  }

  /// UPDATE Trip
  Future<void> updateTrip(String tripId, Map<String, dynamic> data) async {
    await tripsRef.doc(tripId).update(data);
  }

  /// CLOSE Trip (untuk integrasi Booking)
  Future<void> closeTrip(String tripId) async {
    await tripsRef.doc(tripId).update({
      'isOpen': false,
    });
  }

  /// DELETE Trip (opsional)
  Future<void> deleteTrip(String tripId) async {
    await tripsRef.doc(tripId).delete();
  }
}
