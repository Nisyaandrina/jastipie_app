import 'package:cloud_firestore/cloud_firestore.dart';

class TripModel {
  final String id;
  final String jastiperId;
  final String origin;
  final String destination;
  final DateTime departureDate;
  final int quota;
  final double price;
  final String notes;
  final bool isOpen;
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

  /// Firestore → Model
  factory TripModel.fromJson(Map<String, dynamic> json, String documentId) {
    // Helper: parse DateTime safely
    DateTime parseDate(dynamic value) {
      if (value is Timestamp) return value.toDate();
      if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
      return DateTime.now();
    }

    return TripModel(
      id: documentId,
      jastiperId: json['jastiperId'] ?? '',
      origin: json['origin'] ?? '',
      destination: json['destination'] ?? '',
      departureDate: parseDate(json['departureDate']),
      quota: (json['quota'] ?? 0) is int
          ? json['quota']
          : int.tryParse(json['quota'].toString()) ?? 0,
      price: (json['price'] ?? 0) is num
          ? (json['price'] as num).toDouble()
          : double.tryParse(json['price'].toString()) ?? 0,
      notes: json['notes'] ?? '',
      isOpen: json['isOpen'] ?? true,
      createdAt: parseDate(json['createdAt']),
    );
  }

  /// Model → Firestore
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
