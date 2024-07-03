class ChatCardModel {
  final String email;
  final String uid;

  final String? name;

  ChatCardModel({
    this.name,
    required this.email,
    required this.uid,
  });

  factory ChatCardModel.fromJson(dynamic jsonData) {
    return ChatCardModel(
      email: jsonData['email'],
      uid: jsonData['uid'],
      name: jsonData['name'],
    );
  }
}
