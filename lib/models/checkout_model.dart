class CheckoutItem {
  final String title;
  final int price;
  final String imagePath;

  CheckoutItem(this.title, this.price, this.imagePath);
}

class CheckoutGroup {
  final String photographer;
  final List<CheckoutItem> items;

  CheckoutGroup({required this.photographer, required this.items});
}
