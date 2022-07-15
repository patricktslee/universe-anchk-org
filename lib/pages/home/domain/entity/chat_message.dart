class ChatMessage {
  String messageFrom;
  String messageTo;
  String messageContent;
  String messageType;
  ChatMessage(
      {required this.messageFrom,
      required this.messageTo,
      required this.messageContent,
      required this.messageType});

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      messageFrom: map['messageFrom'],
      messageTo: map['messageTo'],
      messageContent: map['messageContent'],
      messageType: map['messageType'],
    );
  }
  @override
  String toString() {
    return 'chatRoom\nmessageFrom: $messageFrom\nmessageTo: $messageTo\nmessageContent: $messageContent\nmessageType: $messageType';
  }
}
