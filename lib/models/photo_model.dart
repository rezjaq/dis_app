import 'dart:io';

class PostPhoto {
  final String id;
  final String url;
  final String name;
  final String description;
  final String type;
  final int likes;
  final List comments;
  final bool liked;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  PostPhoto({
    required this.id,
    required this.url,
    required this.name,
    required this.description,
    required this.type,
    this.likes = 0,
    this.comments = const [],
    this.liked = false,
    required this.userId,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.deletedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory PostPhoto.fromJson(Map<String, dynamic> json) {
    return PostPhoto(
      id: json['id'] ?? '',
      url: json['url'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? '',
      likes: json['likes'] ?? 0,
      comments: json['comments'] ?? [],
      liked: json['liked'] ?? false,
      userId: json['user_id'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      deletedAt: json['deleted_at'] != null ? DateTime.tryParse(json['deleted_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'name': name,
      'description': description,
      'type': type,
      'likes': likes,
      'comments': comments,
      'liked': liked,
      'user_id': userId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
    };
  }
}

class SellPhoto {
  final String id;
  final String url;
  final String name;
  final double basePrice;
  final double sellPrice;
  final String description;
  final String type;
  final String status;
  final String buyerId;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  SellPhoto({
    required this.id,
    required this.url,
    required this.name,
    required this.basePrice,
    required this.sellPrice,
    required this.description,
    required this.type,
    required this.status,
    required this.buyerId,
    required this.userId,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.deletedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'name': name,
      'basePrice': basePrice,
      'sellPrice': sellPrice,
      'description': description,
      'type': type,
      'status': status,
      'buyer_id': buyerId,
      'user_id': userId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
    };
  }

  factory SellPhoto.fromJson(Map<String, dynamic> json) {
    return SellPhoto(
      id: json['id'] ?? '',
      url: json['url'] ?? '',
      name: json['name'] ?? '',
      basePrice: json['basePrice'] ?? 0.0,
      sellPrice: json['sellPrice'] ?? 0.0,
      description: json['description'] ?? '',
      type: json['type'] ?? '',
      status: json['status'] ?? '',
      buyerId: json['buyer_id'] ?? '',
      userId: json['user_id'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      deletedAt: json['deleted_at'] != null ? DateTime.tryParse(json['deleted_at']) : null,
    );
  }
}

class AddSellPhotoRequest {
  String name;
  String basePrice;
  String sellPrice;
  String description;
  File file;

  AddSellPhotoRequest({
    required this.name,
    required this.basePrice,
    required this.sellPrice,
    required this.description,
    required this.file,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'basePrice': basePrice,
      'sellPrice': sellPrice,
      'description': description,
    };
  }
}

class AddPostPhotoRequest {
  String description;
  String name;
  File file;

  AddPostPhotoRequest({
    required this.description,
    required this.name,
    required this.file,
  });

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'name': name,
    };
  }
}

class GetPhotoRequest {
  final String id;

  GetPhotoRequest({
    required this.id,
  });
}

class ListPhotoRequest {
  String? type;
  int? page;
  int? size;

  ListPhotoRequest({
    this.type,
    this.page,
    this.size,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
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

class UpdateSellPhotoRequest {
  final String id;
  final String name;
  final String basePrice;
  final String sellPrice;
  final String description;

  UpdateSellPhotoRequest({
    required this.id,
    required this.name,
    required this.basePrice,
    required this.sellPrice,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'basePrice': basePrice,
      'sellPrice': sellPrice,
      'description': description,
    };
  }
}

class UpdatePostPhotoRequest {
  final String id;
  final String name;
  final String description;

  UpdatePostPhotoRequest({
    required this.id,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
    };
  }
}

class LikePhotoPostRequest {
  final String id;
  final bool liked;

  LikePhotoPostRequest({
    required this.id,
    required this.liked,
  });

  Map<String, dynamic> toJson() {
    return {
      'liked': liked,
    };
  }
}

class CollectionPhotoRequest {
  final String buyerId;
  final int? page;
  final int? size;

  CollectionPhotoRequest({
    required this.buyerId,
    this.page,
    this.size,
  });

  Map<String, dynamic> toJson() {
    return {
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