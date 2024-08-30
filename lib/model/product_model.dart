class ProductModel {
  List<Data>? data;

  ProductModel({this.data});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class Data {
  String? sId;
  String? title;
  String? slug;
  String? description;
  int? price;
  String? category;
  int? quantity;
  List<Images>? images;
  List<String>? tags;
  String? totalrating;
  List<dynamic>? ratings; // Assuming ratings can be of different types
  String? createdAt;
  String? updatedAt;

  Data({
    this.sId,
    this.title,
    this.slug,
    this.description,
    this.price,
    this.category,
    this.quantity,
    this.images,
    this.tags,
    this.totalrating,
    this.ratings,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      sId: json['_id'],
      title: json['title'],
      slug: json['slug'],
      description: json['description'],
      price: json['price'],
      category: json['category'],
      quantity: json['quantity'],
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => Images.fromJson(e as Map<String, dynamic>))
          .toList(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      totalrating: json['totalrating'],
      ratings: json['ratings'], // Adjust based on expected type
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'title': title,
      'slug': slug,
      'description': description,
      'price': price,
      'category': category,
      'quantity': quantity,
      'images': images?.map((e) => e.toJson()).toList(),
      'tags': tags,
      'totalrating': totalrating,
      'ratings': ratings, // Adjust based on expected type
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class Images {
  String? url;
  String? assetId;
  String? publicId;

  Images({this.url, this.assetId, this.publicId});

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      url: json['url'],
      assetId: json['asset_id'],
      publicId: json['public_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'asset_id': assetId,
      'public_id': publicId,
    };
  }
}
