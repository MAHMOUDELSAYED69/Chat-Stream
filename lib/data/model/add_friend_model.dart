class AddFriendModel {
  final String email;
  final String uid;
  final String? image;
  final String? name;
  final bool isFriend;

  AddFriendModel(
      {this.image,
      this.name,
      required this.email,
      required this.uid,
      required this.isFriend});

  factory AddFriendModel.fromJson(dynamic jsonData) {
    return AddFriendModel(
        email: jsonData['email'],
        uid: jsonData['uid'],
        image: jsonData['image'],
        name: jsonData['name'],
        isFriend: jsonData['isFriend']);
  }
}
