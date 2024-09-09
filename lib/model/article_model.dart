class ArticleModel {
  String? status;
  int? results;
  List<Data>? data;

  ArticleModel({this.status, this.results, this.data});

  ArticleModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = json['results'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = <String, dynamic>{};
    jsonData['status'] = status;
    jsonData['results'] = results;
    if (data != null) {
      jsonData['data'] = data!.map((v) => v.toJson()).toList();
    }
    return jsonData;
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
  String? image;
  List<String>? tags;
  String? totalrating;
  String? type;
  List<dynamic>?
      ratings; // Changed to List<dynamic> to accommodate any type of rating
  String? createdAt;
  String? updatedAt;
  String? link;
  Data({
    this.sId,
    this.title,
    this.slug,
    this.description,
    this.price,
    this.category,
    this.quantity,
    this.image,
    this.tags,
    this.totalrating,
    this.type,
    this.ratings,
    this.createdAt,
    this.updatedAt,
    this.link,
  });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    final priceValue = json['price'];
    if (priceValue is int) {
      price = priceValue;
    } else if (priceValue is double) {
      price = priceValue.toInt();
    } else {
      price = int.tryParse(priceValue.toString()) ?? 0;
    }
    category = json['category'];
    quantity = json['quantity'];
    image = json['image'];
    tags = json['tags']?.cast<String>();
    totalrating = json['totalrating'];
    type = json['type'];
    if (json['ratings'] != null) {
      ratings = <dynamic>[]; // Initialize ratings as a List<dynamic>
      json['ratings'].forEach((v) {
        ratings!.add(v); // Directly add the rating value
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = <String, dynamic>{};
    jsonData['_id'] = sId;
    jsonData['title'] = title;
    jsonData['slug'] = slug;
    jsonData['description'] = description;
    jsonData['price'] = price;
    jsonData['category'] = category;
    jsonData['quantity'] = quantity;
    jsonData['image'] = image;
    jsonData['tags'] = tags;
    jsonData['totalrating'] = totalrating;
    jsonData['type'] = type;
    if (ratings != null) {
      jsonData['ratings'] = ratings;
    }
    jsonData['createdAt'] = createdAt;
    jsonData['updatedAt'] = updatedAt;
    jsonData['link'] = link;
    return jsonData;
  }
}
