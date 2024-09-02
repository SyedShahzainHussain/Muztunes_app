class ProductModel {
  String? status;
  int? results;
  List<Data>? data;

  ProductModel({this.status, this.results, this.data});

  ProductModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['results'] = results;
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
  int? price;
  String? category;
  String? information;
  int? quantity;
  List<String>? images;
  List<String>? tags;
  String? totalrating;
  String? type;
  List<dynamic>? ratings; // Changed from List<Null> to List<dynamic>
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
    this.image,
  });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    price = json['price'];
    category = json['category'];
    information = json['information'];
    quantity = json['quantity'];
    images = json['images']
        ?.cast<String>(); // Null-aware operator to handle null lists
    tags = json['tags']?.cast<String>();
    totalrating = json['totalrating'];
    type = json['type'];
    ratings = json['ratings']?.map((v) => v).toList(); // No need to parse Null
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['slug'] = slug;
    data['description'] = description;
    data['price'] = price;
    data['category'] = category;
    data['information'] = information;
    data['quantity'] = quantity;
    data['images'] = images;
    data['tags'] = tags;
    data['totalrating'] = totalrating;
    data['type'] = type;
    if (ratings != null) {
      data['ratings'] =
          ratings; // No need to map toJson() as ratings is dynamic
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['image'] = image;
    return data;
  }
}
