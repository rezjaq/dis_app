class RegisterModel {
  final String email;
  final String password;
  final String confirmPassword;
  final String name;
  final String phone;

  RegisterModel({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.name,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'name': name,
      'phone': phone,
    };
  }
}