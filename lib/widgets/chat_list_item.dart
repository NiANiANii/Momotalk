import 'package:flutter/material.dart';
import '../models/chat.dart';

class ChatListItem extends StatelessWidget {
  final Chat chat;

  const ChatListItem({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.pink[100],
        backgroundImage:
            chat.avatarPath.isNotEmpty ? AssetImage(chat.avatarPath) : null,
        child:
            chat.avatarPath.isEmpty
                ? Text(
                  chat.name[0],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
                : null,
      ),
      title: Text(
        chat.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        chat.lastMessage,
        style: const TextStyle(color: Colors.grey),
      ),
      trailing:
          chat.unread
              ? Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text('1', style: TextStyle(color: Colors.white)),
              )
              : null,
    );
  }
}
