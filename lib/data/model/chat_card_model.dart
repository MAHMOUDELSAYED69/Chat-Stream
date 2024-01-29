class ChatCardModel {
  final String email;
  final String uid;

  ChatCardModel({required this.email, required this.uid});

  factory ChatCardModel.fromJson(dynamic jsonData) {
    return ChatCardModel(email: jsonData['email'], uid: jsonData['uid']);
  }
}
