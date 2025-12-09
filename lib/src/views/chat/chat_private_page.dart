import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/chat_vm.dart';
import '../../widgets/message_bubble.dart';

class ChatPrivatePage extends StatefulWidget {
  final String chatId;
  final String otherId;
  final String currentUserId;

  const ChatPrivatePage({
    super.key,
    required this.chatId,
    required this.otherId,
    required this.currentUserId,
  });

  @override
  State<ChatPrivatePage> createState() => _ChatPrivatePageState();
}

class _ChatPrivatePageState extends State<ChatPrivatePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    final vm = Provider.of<ChatViewModel>(context, listen: false);
    vm.ensureChat(widget.chatId, participants: [widget.currentUserId, widget.otherId]);
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ChatViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Chat dengan ${widget.otherId}')),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: vm.messagesStream(widget.chatId),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final List messages = snapshot.data as List;
                if (messages.isEmpty) {
                  return const Center(child: Text('Mulai percakapan'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: messages.length,
                  itemBuilder: (context, i) {
                    final m = messages[i];
                    // m is MessageModel from service
                    final createdAt = (m.createdAt is Timestamp)
                        ? (m.createdAt as Timestamp).toDate()
                        : (m.createdAt as DateTime);
                    final isMe = m.senderId == widget.currentUserId;
                    return MessageBubble(
                      text: m.text,
                      isMe: isMe,
                      time: createdAt,
                    );
                  },
                );
              },
            ),
          ),
          const Divider(height: 1),
          _buildInput(vm),
        ],
      ),
    );
  }

  Widget _buildInput(ChatViewModel vm) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  hintText: 'Ketik pesan...',
                  border: InputBorder.none,
                ),
                minLines: 1,
                maxLines: 5,
              ),
            ),
            const SizedBox(width: 8),
            vm.isSending
                ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: SizedBox(
                        width: 24, height: 24, child: CircularProgressIndicator()),
                  )
                : IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () async {
                      final text = _controller.text.trim();
                      if (text.isEmpty) return;
                      await vm.sendMessage(
                        chatId: widget.chatId,
                        senderId: widget.currentUserId,
                        text: text,
                      );
                      _controller.clear();
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
