import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/review_model.dart';

class ReviewService {
  final CollectionReference reviewsRef =
      FirebaseFirestore.instance.collection('reviews');

  Future<void> submitReview(ReviewModel review) async {
    await reviewsRef.doc(review.reviewId).set(review.toMap());
  }

  Stream<List<ReviewModel>> getReviewsForJastiper(String jastiperId) {
    return reviewsRef
        .where('jastiperId', isEqualTo: jastiperId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => ReviewModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }
}
