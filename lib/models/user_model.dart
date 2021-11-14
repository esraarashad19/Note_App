class UserModel {
  late String id;
  late String username;
  late String email;
  String? phone;
  late String fullName;
  late String image;
  UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.phone = '02',
    required this.fullName,
    this.image =
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6xSz0eMW7GmpKukczOHvPWWGDqaBCqWA-Mw&usqp=CAU',
  });

  UserModel.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    fullName = json['fullName'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'username': username,
        'email': email,
        'fullName': fullName,
        'phone': phone,
        'image': image,
      };
}
