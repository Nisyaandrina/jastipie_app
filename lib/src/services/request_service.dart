import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jastipie_app/src/models/request_model.dart';
import 'package:jastipie_app/src/utils/logger.dart';

class RequestService {
  final CollectionReference _requestCollection =
      FirebaseFirestore.instance.collection('requests');

  Future<void> createRequest(RequestModel request) async {
    try {
      await _requestCollection.add(request.toMap());
    } catch (e) {
      Logger.e("Gagal membuat request: $e");
      rethrow;
    }
  }

  Stream<List<RequestModel>> getRequests() {
    try {
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
    } catch (e) {
      Logger.e("Gagal membaca request: $e");
      return const Stream.empty();
    }
  }

  Future<RequestModel?> getRequestById(String id) async {
    try {
      final doc = await _requestCollection.doc(id).get();
      if (!doc.exists) return null;

      return RequestModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    } catch (e) {
      Logger.e("Gagal mengambil detail request: $e");
      return null;
    }
  }

  Future<void> updateStatus(String id, String status) async {
    try {
      await _requestCollection.doc(id).update({'status': status});
    } catch (e) {
      Logger.e("Gagal update status: $e");
      rethrow;
    }
  }

  Future<void> deleteRequest(String id) async {
    try {
      await _requestCollection.doc(id).delete();
    } catch (e) {
      Logger.e("Gagal menghapus request: $e");
      rethrow;
    }
  }
}
