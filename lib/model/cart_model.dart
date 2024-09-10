enum ProductType { article, product }

class CartItemModel {
  String productId;
  String title;
  String description;
  double price;
  String image;
  String? information;
  List<String> category;
  List<String>? colors;
  String type;
  String link;
  List<String>? tags;
  List<String>? images;

  int quantity;

  CartItemModel({
    required this.productId,
    required this.description,
    required this.quantity,
    required this.image,
    required this.tags,
    required this.link,
    this.information,
    this.title = "",
    this.category = const [],
    this.colors = const [],
    this.type = "",
    this.price = 0.0,
    this.images,
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
      'type': type,
      'tags': tags,
      'quantity': quantity,
      "images": images,
      "link": link,
      "information": information,
      "color": colors,
    };
  }

  // Create a CartItemModel instance from a map (for deserialization)
  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      productId: map['productId'],
      type: map['type'],
      title: map['title'] ?? "",
      description: map['description'],
      price: map['price'],
      image: map['image'],
      category: List<String>.from(map['category'] ?? []),
      tags: List<String>.from(map['tags'] ?? []),
      quantity: map['quantity'],
      link: map['link'],
      information: map["information"],
      images: List<String>.from(map['images'] ?? []),
      colors: List<String>.from(map['color'] ?? []),
    );
  }
}
