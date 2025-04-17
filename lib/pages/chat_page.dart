import 'package:flutter/material.dart';
import '../models/chat.dart';
import '../models/message.dart';
import '../widgets/message_bubble.dart';

class ChatPage extends StatefulWidget {
  final Chat chat;

  const ChatPage({super.key, required this.chat});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    messages.addAll([
      Message(
        sender: widget.chat.name,
        text: "♡♡",
        avatar: widget.chat.avatarPath,
        isMe: false,
      ),
      Message(
        sender: widget.chat.name,
        text: "Yes. I have a feeling that today is gonna be fun.",
        avatar: widget.chat.avatarPath,
        isMe: false,
      ),
      Message(
        sender: widget.chat.name,
        text: "How was today? Are you having a good time?",
        avatar: widget.chat.avatarPath,
        isMe: false,
      ),
      Message(
        sender: "You",
        text: "You have a great day too, ${widget.chat.name}!",
        avatar: "",
        isMe: true,
      ),
    ]);
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.insert(
          0,
          Message(
            sender: "You",
            text: _controller.text,
            avatar: "",
            isMe: true,
          ),
        );
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chat.name),
        backgroundColor: const Color.fromRGBO(244, 171, 188, 1),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return MessageBubble(message: messages[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: Color.fromRGBO(244, 171, 188, 1),
                  ),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
