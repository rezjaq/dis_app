class Cart {
  final String photoId;
  final String sellerId;
  final String url;
  final String namePhoto;
  final String nameSeller;
  final double price;

  Cart({
    required this.photoId,
    required this.sellerId,
    required this.url,
    required this.namePhoto,
    required this.nameSeller,
    required this.price,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      photoId: json['photo_id'] ?? '',
      sellerId: json['seller_id'] ?? '',
      url: json['url'] ?? '',
      namePhoto: json['name_photo'] ?? '',
      nameSeller: json['name_seller'] ?? '',
      price: json['price'] ?? 0.0,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final Cart otherCart = other as Cart;
    return photoId == otherCart.photoId;
  }

  @override
  int get hashCode => photoId.hashCode;
}

class AddItemRequest {
  final String photoId;

  AddItemRequest({required this.photoId});

  Map<String, dynamic> toJson() {
    return {
      'photo_id': photoId,
    };
  }
}

class RemoveItemRequest {
  final String photoId;

  RemoveItemRequest({required this.photoId});

  Map<String, dynamic> toJson() {
    return {
      'photo_id': photoId,
    };
  }
}

class SelectAllRequest {
  final List<String> photoIds;

  SelectAllRequest({required this.photoIds});

  Map<String, dynamic> toJson() {
    return {
      'photo_ids': photoIds,
    };
  }
}

class ListItemsRequest {
  int? page;
  int? size;

  ListItemsRequest({this.page, this.size});

  Map<String, dynamic> toJson() {
    return {
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