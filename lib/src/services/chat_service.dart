import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String messageId;
  final String chatId;
  final String senderId;
  final String text;
  final Timestamp createdAt;

  MessageModel({
    required this.messageId,
    required this.chatId,
    required this.senderId,
    required this.text,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'messageId': messageId,
      'chatId': chatId,
      'senderId': senderId,
      'text': text,
      'createdAt': createdAt,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      messageId: map['messageId'],
      chatId: map['chatId'],
      senderId: map['senderId'],
      text: map['text'],
      createdAt: map['createdAt'],
    );
  }
}

class ChatService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference chatsRef =
      FirebaseFirestore.instance.collection('chats');

  /// Create or ensure chat document exists.
  /// chatId convention: sorted(uid1_uid2) or provided.
  Future<void> createChatIfNotExists(String chatId, Map<String, dynamic> meta) async {
    final doc = await chatsRef.doc(chatId).get();
    if (!doc.exists) {
      await chatsRef.doc(chatId).set({
        'chatId': chatId,
        'participants': meta['participants'] ?? [],
        'lastMessage': meta['lastMessage'] ?? '',
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  /// Send message to chat
  Future<void> sendMessage(MessageModel message) async {
    final messagesRef = chatsRef.doc(message.chatId).collection('messages');
    await messagesRef.doc(message.messageId).set(message.toMap());

    // update chat meta
    await chatsRef.doc(message.chatId).update({
      'lastMessage': message.text,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Stream messages for a chat ordered by createdAt asc
  Stream<List<MessageModel>> streamMessages(String chatId) {
    final messagesRef = chatsRef.doc(chatId).collection('messages');
    return messagesRef
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snap) => snap.docs
            .map((d) => MessageModel.fromMap(d.data() as Map<String, dynamic>))
            .toList());
  }

  /// List chats for a user (by participant id) with lastMessage and updatedAt
  Stream<List<Map<String, dynamic>>> streamUserChats(String userId) {
    return chatsRef
        .where('participants', arrayContains: userId)
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((snap) =>
            snap.docs.map((d) => d.data() as Map<String, dynamic>).toList());
  }
}
