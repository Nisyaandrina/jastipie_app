import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/trip_model.dart';

class TripService {
  final CollectionReference tripsRef =
      FirebaseFirestore.instance.collection('trips');

  /// CREATE Trip: generate new doc id and return it
  Future<String> createTrip(TripModel trip) async {
    try {
      final docRef = tripsRef.doc(); // auto-generated id
      await docRef.set(trip.toJson());
      return docRef.id;
    } catch (e) {
      // rethrow or handle logging
      rethrow;
    }
  }

  Future<List<TripModel>> getTrips() async {
    final snapshot = await tripsRef.orderBy('createdAt', descending: true).get();
    return snapshot.docs
        .map((doc) =>
            TripModel.fromJson(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  Future<TripModel?> getTripById(String tripId) async {
    final doc = await tripsRef.doc(tripId).get();
    if (!doc.exists) return null;
    return TripModel.fromJson(doc.data() as Map<String, dynamic>, doc.id);
  }

  Future<void> updateTrip(String tripId, Map<String, dynamic> data) async {
    await tripsRef.doc(tripId).update(data);
  }

  Future<void> closeTrip(String tripId) async {
    await tripsRef.doc(tripId).update({'isOpen': false});
  }

  Future<void> deleteTrip(String tripId) async {
    await tripsRef.doc(tripId).delete();
  }
}
