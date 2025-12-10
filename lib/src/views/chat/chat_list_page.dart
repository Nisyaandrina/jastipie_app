import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/chat_vm.dart';
import 'package:jastipie_app/app_router.dart';

class ChatListPage extends StatelessWidget {
  final String currentUserId;

  const ChatListPage({super.key, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ChatViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: vm.userChatsStream(currentUserId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final chats = snapshot.data!;
          if (chats.isEmpty) {
            return const Center(child: Text('Belum ada percakapan'));
          }

          return ListView.separated(
            itemCount: chats.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, i) {
              final chat = chats[i];
              final chatId = chat['chatId'] as String? ?? '';
              final lastMessage = chat['lastMessage'] as String? ?? '';
              final participants = List<String>.from(
                chat['participants'] ?? [],
              );

              // other participant id
              final other = participants.firstWhere(
                (p) => p != currentUserId,
                orElse: () => currentUserId,
              );

              return ListTile(
                title: Text('Chat dengan $other'),
                subtitle: Text(lastMessage),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRouter.chatPrivateRoute,
                    arguments: {
                      'chatId': chatId,
                      'otherId': other,
                      'currentUserId': currentUserId,
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
