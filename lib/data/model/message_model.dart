class MessageModel {
  final String senderEmail;
  final String senderId;
  final String receiverId;
  final String message;
  final String timeTamp;

  MessageModel(
      {required this.senderEmail,
      required this.senderId,
      required this.receiverId,
      required this.message,
      required this.timeTamp});

  factory MessageModel.fromJson(dynamic jsonData) {
    return MessageModel(
        senderEmail: jsonData['senderEmail'],
        senderId: jsonData['senderId'],
        receiverId: jsonData['receiverId'],
        message: jsonData['message'],
        timeTamp: jsonData['timeTamp']);
  }
  Map<String, dynamic> toJson() {
    return {
      'senderEmail': senderEmail,
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timeTamp': timeTamp,
    };
  }
}
