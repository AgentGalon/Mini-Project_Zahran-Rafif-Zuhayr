import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:car_wash_app/models/chatbot.dart';
import 'package:car_wash_app/api/key/api_openai.dart';

class ChatBotProvider with ChangeNotifier {
  TextEditingController messageController = TextEditingController();
  List<ChatMessage> chatMessages = [];

  Future<void> _getChatBotResponse(String query) async {
    // token API dari OpenAI
    const token = OpenAiKey.openaiToken;

    // ketika respons dari chat bot.
    addChatMessage('Typing...', isBotResponse: true);

    if (_isAllowedTopic(query)) {
      try {
        final response = await http.post(
          Uri.parse('https://api.openai.com/v1/completions'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            'model': 'text-davinci-003',
            'prompt': 'Question: $query\nBot:',
            'max_tokens': 30,
            'temperature': 1,
            'top_p': 1,
          }),
        );

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          String botResponse = data['choices'][0]['text'].trim();

          // Hapus teks "Typing..." dari daftar pesan jika sudah merespon
          chatMessages.removeWhere((message) => message.text == 'Typing...');
          addChatMessage(botResponse, isBotResponse: true);
        } else {
          addChatMessage('Failed to get response.', isBotResponse: true);
        }
      } catch (error) {
        addChatMessage('Error: $error', isBotResponse: true);
      }
    } else {
      // Jika pertanyaan berada di luar topik, akan mengeluarkan teks ini
      addChatMessage(
        'I apologize, I cannot answer your question.',
        isBotResponse: true,
      );
    }
    notifyListeners();
  }

  bool _isAllowedTopic(String question) {
    return question.toLowerCase().contains('car wash') ||
        question.toLowerCase().contains('bronze package') ||
        question.toLowerCase().contains('silver package') ||
        question.toLowerCase().contains('gold package') ||
        question.toLowerCase().contains('platinum package') ||
        question.toLowerCase().contains('sport') ||
        question.toLowerCase().contains('sedan') ||
        question.toLowerCase().contains('suv') ||
        question.toLowerCase().contains('classic');
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
