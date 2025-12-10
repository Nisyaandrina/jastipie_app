import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UserService {
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('users');

  /// GET user by ID
  Future<UserModel?> getUserById(String userId) async {
    final doc = await usersRef.doc(userId).get();
    if (!doc.exists) return null;

    return UserModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
  }

  /// UPDATE user profile
  Future<void> updateProfile(String userId, Map<String, dynamic> data) async {
    data['updatedAt'] = Timestamp.now();
    await usersRef.doc(userId).update(data);
  }

  /// CREATE user (dipanggil saat register)
  Future<void> createUser(UserModel user) async {
    await usersRef.doc(user.id).set(user.toMap());
  }
}
