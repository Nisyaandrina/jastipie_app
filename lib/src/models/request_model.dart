import 'package:cloud_firestore/cloud_firestore.dart';

class RequestModel {
  final String id;
  final String penitipId;
  final String itemName;
  final String category;
  final double priceEst;
  final double weight;
  final String note;
  final String status;
  final DateTime createdAt;

  RequestModel({
    required this.id,
    required this.penitipId,
    required this.itemName,
    required this.category,
    required this.priceEst,
    required this.weight,
    required this.note,
    required this.status,
    required this.createdAt,
  });

  factory RequestModel.fromMap(Map<String, dynamic> data, String documentId) {
    final createdAtField = data['created_at'];

    return RequestModel(
      id: documentId,
      penitipId: data['penitip_id'] ?? '',
      itemName: data['item_name'] ?? '',
      category: data['category'] ?? '',
      priceEst: (data['price_est'] ?? 0).toDouble(),
      weight: (data['weight'] ?? 0).toDouble(),
      note: data['note'] ?? '',
      status: data['status'] ?? 'PENDING',
      createdAt: createdAtField is Timestamp
          ? createdAtField.toDate()
          : DateTime.tryParse(createdAtField ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'penitip_id': penitipId,
      'item_name': itemName,
      'category': category,
      'price_est': priceEst,
      'weight': weight,
      'note': note,
      'status': status,
      'created_at': Timestamp.fromDate(createdAt),
    };
  }
}
