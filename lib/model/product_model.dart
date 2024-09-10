class ProductModel {
  String? status;
  int? results;
  List<Data>? data;

  ProductModel({this.status, this.results, this.data});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      status: json['status'] as String?,
      results: json['results'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => Data.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'results': results,
      'data': data?.map((item) => item.toJson()).toList(),
    };
  }
}

class Data {
  String? sId;
  String? title;
  String? slug;
  String? description;
  double? price;
  List<String>? category;
  String? information;
  int? quantity;
  List<String>? images;
  List<String>? tags;
  String? totalrating;
  String? type;
  List<Ratings>? ratings;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? link;
  String? image;

  Data({
    this.sId,
    this.title,
    this.slug,
    this.description,
    this.price,
    this.category,
    this.information,
    this.quantity,
    this.images,
    this.tags,
    this.totalrating,
    this.type,
    this.ratings,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.link,
    this.image,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      sId: json['_id'] as String?,
      title: json['title'] as String?,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      category: (json['category'] as List<dynamic>?)?.map((item) => item as String).toList(),
      information: json['information'] as String?,
      quantity: json['quantity'] as int?,
      images: (json['images'] as List<dynamic>?)?.map((item) => item as String).toList(),
      tags: (json['tags'] as List<dynamic>?)?.map((item) => item as String).toList(),
      totalrating: json['totalrating'] as String?,
      type: json['type'] as String?,
      ratings: (json['ratings'] as List<dynamic>?)
          ?.map((item) => Ratings.fromJson(item as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      iV: json['__v'] as int?,
      link: json['link'] as String?,
      image: json['image'] as String?,
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
      'information': information,
      'quantity': quantity,
      'images': images,
      'tags': tags,
      'totalrating': totalrating,
      'type': type,
      'ratings': ratings?.map((item) => item.toJson()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': iV,
      'link': link,
      'image': image,
    };
  }
}

class Ratings {
  int? star;
  String? comment;
  String? postedby;
  String? sId;

  Ratings({this.star, this.comment, this.postedby, this.sId});

  factory Ratings.fromJson(Map<String, dynamic> json) {
    return Ratings(
      star: json['star'] as int?,
      comment: json['comment'] as String?,
      postedby: json['postedby'] as String?,
      sId: json['_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'star': star,
      'comment': comment,
      'postedby': postedby,
      '_id': sId,
    };
  }
}
