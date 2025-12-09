import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/review_service.dart';
import '../models/review_model.dart';

class ReviewViewModel extends ChangeNotifier {
  final ReviewService _service = ReviewService();

  bool isLoading = false;
  String errorMessage = '';

  Future<void> sendReview({
    required String reviewerId,
    required String jastiperId,
    required String bookingId,
    required double rating,
    required String comment,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      final review = ReviewModel(
        reviewId: const Uuid().v4(),
        reviewerId: reviewerId,
        jastiperId: jastiperId,
        bookingId: bookingId,
        rating: rating,
        comment: comment,
        createdAt: Timestamp.now(),
      );

      await _service.submitReview(review);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Stream<List<ReviewModel>> reviewStream(String jastiperId) {
    return _service.getReviewsForJastiper(jastiperId);
  }
}
