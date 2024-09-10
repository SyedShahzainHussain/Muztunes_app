class ProductModel {
  String? status;
  int? results;
  List<Data>? data;

  ProductModel({this.status, this.results, this.data});

  ProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = json['results'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = this.status;
    data['results'] = this.results;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? title;
  String? slug;
  String? description;
  dynamic price;
  List<String>? category;
  List<String>? colors;
  String? information;
  int? quantity;
  List<String>? images;
  String? link;
  List<String>? tags;
  String? totalrating;
  String? type;
  List<Ratings>? ratings; // Changed from List<Null> to List<Rating>
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? image;

  Data({
    this.sId,
    this.title,
    this.slug,
    this.description,
    this.price,
    this.category,
    this.colors,
    this.information,
    this.quantity,
    this.images,
    this.link,
    this.tags,
    this.totalrating,
    this.type,
    this.ratings,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.image
  });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    price = json['price'];
    category = json['category']?.cast<String>();
    colors = json['color']?.cast<String>();
    information = json['information'];
    quantity = json['quantity'];
    images = json['images']?.cast<String>();
    link = json['link'];
    tags = json['tags']?.cast<String>();
    totalrating = json['totalrating'];
    type = json['type'];
    if (json['ratings'] != null) {
      ratings = [];
      json['ratings'].forEach((v) {
        ratings!.add(Ratings.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['price'] = this.price;
    data['category'] = this.category;
    data['color'] = this.colors;
    data['information'] = this.information;
    data['quantity'] = this.quantity;
    data['images'] = this.images;
    data['link'] = this.link;
    data['tags'] = this.tags;
    data['totalrating'] = this.totalrating;
    data['type'] = this.type;
    if (this.ratings != null) {
      data['ratings'] = this.ratings!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['image'] = this.image;
    return data;
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
