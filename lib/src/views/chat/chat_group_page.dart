import 'package:flutter/material.dart';

class ChatGroupPage extends StatelessWidget {
  const ChatGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Group Chat (UI only)')),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.group, size: 64, color: Colors.grey),
                  SizedBox(height: 12),
                  Text(
                    'Group chat sedang dalam pengembangan.',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 6),
                  Text('Fitur UI siap — integrasi realtime akan menyusul.'),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Kembali'),
            ),
          ),
        ],
      ),
    );
  }
}
