import 'package:cloud_firestore/cloud_firestore.dart';

class TripModel {
  final String id;
  final String jastiperId;
  final String origin;
  final destination;
  final DateTime departureDate;
  final int quota;
  final double price;
  final String notes;
  final bool isOpen; // untuk booking
  final DateTime createdAt;

  TripModel({
    required this.id,
    required this.jastiperId,
    required this.origin,
    required this.destination,
    required this.departureDate,
    required this.quota,
    required this.price,
    required this.notes,
    required this.isOpen,
    required this.createdAt,
  });

  /// Convert Firestore -> Model
  factory TripModel.fromJson(Map<String, dynamic> json, String documentId) {
    return TripModel(
      id: documentId,
      jastiperId: json['jastiperId'] ?? '',
      origin: json['origin'] ?? '',
      destination: json['destination'] ?? '',
      departureDate: (json['departureDate'] as Timestamp).toDate(),
      quota: json['quota'] ?? 0,
      price: (json['price'] as num).toDouble(),
      notes: json['notes'] ?? '',
      isOpen: json['isOpen'] ?? true,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  /// Convert Model -> Firestore
  Map<String, dynamic> toJson() {
    return {
      'jastiperId': jastiperId,
      'origin': origin,
      'destination': destination,
      'departureDate': Timestamp.fromDate(departureDate),
      'quota': quota,
      'price': price,
      'notes': notes,
      'isOpen': isOpen,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
