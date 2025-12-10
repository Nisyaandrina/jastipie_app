import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message_model.dart';
import '../services/chat_service.dart';

class ChatViewModel extends ChangeNotifier {
  final ChatService _service = ChatService();

  bool isSending = false;
  String errorMessage = '';

  /// Ensure chat exists
  Future<void> ensureChat(
    String chatId, {
    required List<String> participants,
  }) async {
    try {
      await _service.createChatIfNotExists(chatId, {
        'participants': participants,
        'lastMessage': '',
      });
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  /// Send message
  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String text,
  }) async {
    try {
      isSending = true;
      notifyListeners();

      final message = MessageModel(
        messageId: const Uuid().v4(),
        chatId: chatId,
        senderId: senderId,
        text: text,
        createdAt: Timestamp.now(),
      );

      await _service.sendMessage(message);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isSending = false;
      notifyListeners();
    }
  }

  /// Stream messages
  Stream<List<MessageModel>> messagesStream(String chatId) {
    return _service.streamMessages(chatId);
  }

  /// Stream chats for user
  Stream<List<Map<String, dynamic>>> userChatsStream(String userId) {
    return _service.streamUserChats(userId);
  }
}
