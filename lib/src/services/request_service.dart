import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jastipie_app/src/models/request_model.dart';
import 'package:jastipie_app/src/utils/logger.dart';

class RequestService {
  final CollectionReference _requestCollection = FirebaseFirestore.instance
      .collection('requests');

  // Create Request
  Future<void> createRequest(RequestModel request) async {
    try {
      await _requestCollection.add(request.toMap());
    } catch (e) {
      Logger.e("Gagal membuat request: $e");
      rethrow;
    }
  }

  // Read All Requests (Realtime)
  Stream<List<RequestModel>> getRequests() {
    return _requestCollection
        .orderBy('created_at', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return RequestModel.fromMap(
              doc.data() as Map<String, dynamic>,
              doc.id,
            );
          }).toList();
        });
  }

  // Read Single Request
  Future<RequestModel?> getRequestById(String id) async {
    try {
      DocumentSnapshot doc = await _requestCollection.doc(id).get();
      if (doc.exists) {
        return RequestModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }
      return null;
    } catch (e) {
      Logger.e("Gagal mengambil detail request: $e");
      return null;
    }
  }

  // Delete Request
  Future<void> deleteRequest(String id) async {
    try {
      await _requestCollection.doc(id).delete();
    } catch (e) {
      Logger.e("Gagal menghapus request: $e");
      rethrow;
    }
  }
}
