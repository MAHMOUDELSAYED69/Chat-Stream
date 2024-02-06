class ChatCardModel {
  final String email;
  final String uid;
  final String? image;
  final String? name;

  ChatCardModel(
      {this.image, this.name, required this.email, required this.uid});

  factory ChatCardModel.fromJson(dynamic jsonData) {
    return ChatCardModel(
        email: jsonData['email'],
        uid: jsonData['uid'],
        image: jsonData['image'],
        name: jsonData['name']);
  }
}
