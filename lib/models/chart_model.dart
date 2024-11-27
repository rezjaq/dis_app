class CartItem {
  final String title;
  final String photographer;
  final int price;
  final String imagePath;

  CartItem(this.title, this.photographer, this.price, this.imagePath);

  static fromJson(item) {}
}
