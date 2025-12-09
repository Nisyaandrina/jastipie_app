import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String reviewId;
  final String reviewerId;
  final String jastiperId;
  final String bookingId;
  final double rating;
  final String comment;
  final Timestamp createdAt;

  ReviewModel({
    required this.reviewId,
    required this.reviewerId,
    required this.jastiperId,
    required this.bookingId,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'reviewId': reviewId,
      'reviewerId': reviewerId,
      'jastiperId': jastiperId,
      'bookingId': bookingId,
      'rating': rating,
      'comment': comment,
      'createdAt': createdAt,
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      reviewId: map['reviewId'],
      reviewerId: map['reviewerId'],
      jastiperId: map['jastiperId'],
      bookingId: map['bookingId'],
      rating: (map['rating'] as num).toDouble(),
      comment: map['comment'],
      createdAt: map['createdAt'],
    );
  }
}
