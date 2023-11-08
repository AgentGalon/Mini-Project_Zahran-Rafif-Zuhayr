import 'package:flutter/material.dart';

import 'package:car_wash_app/models/chatbot.dart';
import 'package:car_wash_app/services/chatbot_service.dart';

class ChatBotProvider with ChangeNotifier {
  TextEditingController messageController = TextEditingController();
  List<ChatMessage> chatMessages = [];

  Future<void> _getChatBotResponse(String query) async {
    addChatMessage('Typing...', isBotResponse: true);

    String botResponse = await ChatBotService.getChatBotResponse(query);

    chatMessages.removeWhere((message) => message.text == 'Typing');
    addChatMessage(botResponse, isBotResponse: true);

    notifyListeners();
  }

  void addChatMessage(String text, {bool isBotResponse = false}) {
    ChatMessage message = ChatMessage(text: text, isBotResponse: isBotResponse);
    chatMessages.add(message);
    notifyListeners();
  }

  void handleSubmittedMessage(String text) {
    if (text.isNotEmpty) {
      addChatMessage(text);
      _getChatBotResponse(text);
      messageController.clear();
    }
  }

  void clearChat() {
    chatMessages.clear();
    notifyListeners();
  }
}
