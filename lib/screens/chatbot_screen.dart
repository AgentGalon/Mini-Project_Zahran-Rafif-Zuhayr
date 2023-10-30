import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:car_wash_app/models/chatbot.dart';
import 'package:car_wash_app/providers/chatbot_provider.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  @override
  Widget build(BuildContext context) {
    final chatBotProvider = Provider.of<ChatBotProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text('Chat Bot'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: chatBotProvider.clearChat,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: chatBotProvider.chatMessages.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                  message: chatBotProvider.chatMessages[index],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: chatBotProvider.messageController,
                    onSubmitted: chatBotProvider.handleSubmittedMessage,
                    decoration: const InputDecoration(
                      labelText: 'Type your question...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send_rounded),
                  onPressed: () {
                    chatBotProvider.handleSubmittedMessage(
                        chatBotProvider.messageController.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        crossAxisAlignment: message.isBotResponse
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              message.isBotResponse ? 'Bot' : 'You',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color:
                  message.isBotResponse ? Colors.grey[200] : Colors.redAccent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              message.text,
              style: TextStyle(
                color: message.isBotResponse ? Colors.black : Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
