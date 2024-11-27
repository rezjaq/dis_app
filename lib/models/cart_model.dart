class Cart {
  final String id;
  final List<String> photos;
  final String userId;

  Cart({required this.id, required this.photos, required this.userId});

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['_id'],
      photos: List<String>.from(json['photos']),
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'photos': photos,
      'user_id': userId,
    };
  }
}

class AddItemRequest {
  final String photoId;
  final String userId;

  AddItemRequest({required this.photoId, required this.userId});

  Map<String, dynamic> toJson() {
    return {
      'photo_id': photoId,
      'user_id': userId,
    };
  }
}

class RemoveItemRequest {
  final String photoId;
  final String userId;

  RemoveItemRequest({required this.photoId, required this.userId});

  Map<String, dynamic> toJson() {
    return {
      'photo_id': photoId,
      'user_id': userId,
    };
  }
}

class ListItemsRequest {
  final String userId;
  int? page;
  int? size;

  ListItemsRequest({required this.userId, this.page, this.size});

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'page': page,
      'size': size,
    };
  }

  String toQueryParams() {
    final params = <String, dynamic>{};
    if (page != null) {
      params['page'] = page;
    }
    if (size != null) {
      params['size'] = size;
    }
    return Uri(queryParameters: params).query;
  }
}