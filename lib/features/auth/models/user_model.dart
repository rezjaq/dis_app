class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String password;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }
}