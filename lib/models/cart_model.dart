class AddToCartRequest {
  final String userId;
  final String productId;
  final int quantity;

  AddToCartRequest({required this.userId, required this.productId, required this.quantity});

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'productId': productId,
      'quantity': quantity,
    };
  }
}

class RemoveFromCartRequest {
  final String id;

  RemoveFromCartRequest({required this.id});
}

class UpdateCartRequest {
  final String id;
  final int quantity;

  UpdateCartRequest({required this.id, required this.quantity});

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
    };
  }
}

class GetCartRequest {
  final String userId;

  GetCartRequest({required this.userId});
}

class ListCartRequest {
  final String? userId;

  ListCartRequest({this.userId});

  String toQueryParams() {
    return userId != null ? 'userId=$userId' : '';
  }
}
