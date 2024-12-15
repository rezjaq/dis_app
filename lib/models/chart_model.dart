class CartItem {
  final String title;
  final String photographer;
  final int price;
  final String imagePath;

  // Constructor with named parameters
  CartItem({
    required this.title,
    required this.photographer,
    required this.price,
    required this.imagePath,
  });

  // Optionally, you can add the fromJson method if needed
  static CartItem fromJson(Map<String, dynamic> item) {
    return CartItem(
      title: item['title'] ?? '',
      photographer: item['photographer'] ?? '',
      price: item['price'] ?? 0,
      imagePath: item['imagePath'] ?? '',
    );
  }
}

class AddItemCartRequest {
  final String photoId;

  AddItemCartRequest({
    required this.photoId,
  });

  Map<String, dynamic> toJson() {
    return {
      'photo_id': photoId,
    };
  }
}