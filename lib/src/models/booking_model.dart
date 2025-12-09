import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String bookingId;
  final String tripId;
  final String penitipId;
  final String jastiperId;
  final String itemName;
  final String itemLink;
  final double estimatedPrice;
  final String note;
  final String status; // pending, accepted, rejected
  final Timestamp createdAt;

  BookingModel({
    required this.bookingId,
    required this.tripId,
    required this.penitipId,
    required this.jastiperId,
    required this.itemName,
    required this.itemLink,
    required this.estimatedPrice,
    required this.note,
    required this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'bookingId': bookingId,
      'tripId': tripId,
      'penitipId': penitipId,
      'jastiperId': jastiperId,
      'itemName': itemName,
      'itemLink': itemLink,
      'estimatedPrice': estimatedPrice,
      'note': note,
      'status': status,
      'createdAt': createdAt,
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      bookingId: map['bookingId'],
      tripId: map['tripId'],
      penitipId: map['penitipId'],
      jastiperId: map['jastiperId'],
      itemName: map['itemName'],
      itemLink: map['itemLink'],
      estimatedPrice: (map['estimatedPrice'] as num).toDouble(),
      note: map['note'],
      status: map['status'],
      createdAt: map['createdAt'],
    );
  }
}
