class CartItemModel {
  String productId;
  String title;
  String description;
  double price;
  String image;
  String category;
  List<String>? tags;
  int quantity;

  CartItemModel({
    required this.productId,
    required this.description,
    required this.quantity,
    required this.image,
    required this.tags,
    this.title = "",
    this.category = "",
    this.price = 0.0,
  });

  // Convert a CartItemModel instance into a map (for serialization)
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'title': title,
      'description': description,
      'price': price,
      'image': image,
      'category': category,
      'tags': tags,
      'quantity': quantity,
    };
  }

  // Create a CartItemModel instance from a map (for deserialization)
  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      productId: map['productId'],
      title: map['title'] ?? "",
      description: map['description'],
      price: map['price'],
      image: map['image'],
      category: map['category'] ?? "",
      tags: List<String>.from(map['tags'] ?? []),
      quantity: map['quantity'],
    );
  }
}
