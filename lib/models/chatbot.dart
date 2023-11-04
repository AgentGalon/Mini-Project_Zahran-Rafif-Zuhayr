class ChatMessage {
  final String text;
  final bool isBotResponse;

  ChatMessage({required this.text, this.isBotResponse = false});
}
