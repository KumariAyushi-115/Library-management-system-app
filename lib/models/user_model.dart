class User {
  final int userId;
  final String userName;
  final String email;
  final String contact;
  final String address;

  User({
    required this.userId,
    required this.userName,
    required this.email,
    required this.contact,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      userName: json['userName'],
      email: json['email'],
      contact: json['contact'],
      address: json['address'],
    );
  }
}
