class ArticleModel {
  String? status;
  int? results;
  List<Data>? data;

  ArticleModel({this.status, this.results, this.data});

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
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
  dynamic? price;
  String? category;
  dynamic quantity;
  String? image;
  String? link;
  List<String>? tags;
  String? totalrating;
  String? type;
  List<Rating>? ratings; // Assuming a Rating class or similar
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
    this.image,
    this.link,
    this.tags,
    this.totalrating,
    this.type,
    this.ratings,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      sId: json['_id'] as String?,
      title: json['title'] as String?,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      price: json['price'] as dynamic?,
      category: json['category'],
      quantity: json['quantity'] as int?,
      image: json['image'] as String?,
      link: json['link'] as String?,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((item) => item as String)
          .toList(),
      totalrating: json['totalrating'] as String?,
      type: json['type'] as String?,
      ratings: (json['ratings'] as List<dynamic>?)
          ?.map((item) => Rating.fromJson(item as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
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
      'image': image,
      'link': link,
      'tags': tags,
      'totalrating': totalrating,
      'type': type,
      'ratings': ratings?.map((item) => item.toJson()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class Rating {
  // Define this class according to your needs
  int? star;
  String? comment;
  String? postedBy;
  String? sId;

  Rating({this.star, this.comment, this.postedBy, this.sId});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      star: json['star'] as int?,
      comment: json['comment'] as String?,
      postedBy: json['postedby'] as String?,
      sId: json['_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'star': star,
      'comment': comment,
      'postedby': postedBy,
      '_id': sId,
    };
  }
}
