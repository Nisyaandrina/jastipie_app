import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message_model.dart';

class ChatService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference get chatsRef => _db.collection('chats');

  /// Create chat if not exists
  Future<void> createChatIfNotExists(
    String chatId,
    Map<String, dynamic> meta,
  ) async {
    try {
      final doc = await chatsRef.doc(chatId).get();

      if (!doc.exists) {
        await chatsRef.doc(chatId).set({
          'chatId': chatId,
          'participants': meta['participants'] ?? [],
          'lastMessage': meta['lastMessage'] ?? '',
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      throw Exception("Gagal membuat chat: $e");
    }
  }

  /// Send message to chat
  Future<void> sendMessage(MessageModel message) async {
    try {
      // note: tidak menggunakan collection<Map<...>> karena versi firestoremu tidak menerima generic
      final messagesRef = chatsRef.doc(message.chatId).collection('messages');

      // Save message
      await messagesRef.doc(message.messageId).set(message.toMap());

      // Update chat metadata
      await chatsRef.doc(message.chatId).update({
        'lastMessage': message.text,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception("Gagal mengirim pesan: $e");
    }
  }

  /// Stream messages ordered by time (ASC)
  Stream<List<MessageModel>> streamMessages(String chatId) {
    final messagesRef = chatsRef.doc(chatId).collection('messages');

    return messagesRef
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snap) {
      return snap.docs.map((d) {
        // Konversi aman ke Map<String, dynamic>
        final data = Map<String, dynamic>.from(d.data() as Map);
        return MessageModel.fromMap(data);
      }).toList();
    });
  }

  /// Stream all chats where user is a participant
  Stream<List<Map<String, dynamic>>> streamUserChats(String userId) {
    return chatsRef
        .where('participants', arrayContains: userId)
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((snap) {
      return snap.docs.map((d) {
        return Map<String, dynamic>.from(d.data() as Map);
      }).toList();
    });
  }
}
