import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:car_wash_app/api/key/api_openai.dart';

class ChatBotService {
  static bool _isAllowedTopic(String question) {
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

  static Future<String> getChatBotResponse(String query) async {
    if (!_isAllowedTopic(query)) {
      return 'I apologize, I cannot answer your question.';
    }

    const token = OpenAiKey.openaiToken;

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
          'max_tokens': 50,
          'temperature': 1,
          'top_p': 1,
        }),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        String botResponse = data['choices'][0]['text'].trim();
        return botResponse;
      } else {
        return 'Failed to get response.';
      }
    } catch (error) {
      return 'Error: $error';
    }
  }
}
