import 'package:camera/camera.dart';
import 'package:dis_app/models/account_model.dart';

enum UserRole { admin, user }

class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? username;
  final String? photo;
  final UserRole role;
  final DateTime? emailVerifiedAt;
  final double balance;
  final List<Account> accounts;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.username,
    this.photo,
    required this.role,
    this.emailVerifiedAt,
    required this.balance,
    required this.accounts,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.deletedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      username: json['username'],
      photo: json['photo'],
      role: UserRole.values
          .firstWhere((e) => e.toString().split('.').last == json['role']),
      emailVerifiedAt: json['emailVerifiedAt'] != null
          ? DateTime.parse(json['emailVerifiedAt'])
          : null,
      balance: json['balance'],
      accounts: (json['accounts'] as List)
          .map((account) => Account.fromJson(account))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'username': username,
      'photo': photo,
      'role': role.toString().split('.').last,
      'emailVerifiedAt': emailVerifiedAt?.toIso8601String(),
      'balance': balance,
      'accounts': accounts.map((account) => account.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
    };
  }
}

class RegisterUserRequest {
  final String name;
  final String email;
  final String phone;
  final String password;

  RegisterUserRequest({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }
}

class LoginUserRequest {
  final String emailOrPhone;
  final String password;

  LoginUserRequest({
    required this.emailOrPhone,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email_or_phone': emailOrPhone,
      'password': password,
    };
  }
}

class UpdateUserRequest {
  final String? name;
  final String? email;
  final String? phone;
  final String? username;

  UpdateUserRequest({
    this.name,
    this.email,
    this.phone,
    this.username,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'username': username,
    };
  }
}

class ChangePasswordRequest {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  ChangePasswordRequest({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'old_password': oldPassword,
      'new_password': newPassword,
      'confirm_password': confirmPassword,
    };
  }
}

class AddAccountRequest {
  final String bank;
  final String name;
  final String number;

  AddAccountRequest({
    required this.bank,
    required this.name,
    required this.number,
  });

  Map<String, dynamic> toJson() {
    return {
      'bank': bank,
      'name': name,
      'number': number,
    };
  }
}

class ListAccountRequest {
  String? bank;
  String? name;
  String? number;
  int? page;
  int? size;

  ListAccountRequest({
    this.bank,
    this.name,
    this.number,
    this.page,
    this.size,
  });

  Map<String, dynamic> toJson() {
    return {
      'bank': bank,
      'name': name,
      'number': number,
      'page': page,
      'size': size,
    };
  }

  String toQueryParams() {
    final params = toJson();
    params.removeWhere((key, value) => value == null);
    return params.entries.map((e) => '${e.key}=${e.value}').join('&');
  }
}

class GetAccountRequest {
  final String id;

  GetAccountRequest({
    required this.id,
  });
}

class UpdateAccountRequest {
  final String id;
  final String bank;
  final String name;
  final String number;

  UpdateAccountRequest({
    required this.id,
    required this.bank,
    required this.name,
    required this.number,
  });

  Map<String, dynamic> toJson() {
    return {
      'bank': bank,
      'name': name,
      'number': number,
    };
  }
}

class DeleteAccountRequest {
  final String id;

  DeleteAccountRequest({
    required this.id,
  });
}

class ChangePhotoRequest {
  final XFile photo;

  ChangePhotoRequest({
    required this.photo,
  });

  Map<String, dynamic> toJson() {
    return {
      'photo': photo,
    };
  }
}

class ChangeProfileRequest {
  final String name;
  final String email;
  final String phone;
  final String username;

  ChangeProfileRequest({
    required this.name,
    required this.email,
    required this.phone,
    required this.username,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'username': username,
    };
  }
}
