import 'dart:convert';

class OrderModel {
  String? sId;
  List<Products>? products;
  PaymentIntent? paymentIntent;
  String? orderStatus;
  Orderby? orderby;
  String? createdAt;
  String? updatedAt;
  int? iV;

  OrderModel({
    this.sId,
    this.products,
    this.paymentIntent,
    this.orderStatus,
    this.orderby,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      sId: json['_id'],
      products: json['products'] != null
          ? List<Products>.from(json['products'].map((v) => Products.fromJson(v)))
          : null,
      paymentIntent: json['paymentIntent'] != null
          ? PaymentIntent.fromJson(json['paymentIntent'])
          : null,
      orderStatus: json['orderStatus'],
      orderby: json['orderby'] != null
          ? Orderby.fromJson(json['orderby'])
          : null,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      iV: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    if (paymentIntent != null) {
      data['paymentIntent'] = paymentIntent!.toJson();
    }
    data['orderStatus'] = orderStatus;
    if (orderby != null) {
      data['orderby'] = orderby!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Products {
  Product? product;
  int? count;
  String? sId;

  Products({this.product, this.count, this.sId});

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      product: json['product'] != null ? Product.fromJson(json['product']) : null,
      count: json['count'],
      sId: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['count'] = count;
    data['_id'] = sId;
    return data;
  }
}

class Product {
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
  List<dynamic>? ratings; // Changed from List<Null> to List<dynamic>
  String? createdAt;
  String? updatedAt;
  int? iV;

  Product({
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
    this.iV,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      sId: json['_id'],
      title: json['title'],
      slug: json['slug'],
      description: json['description'],
      price: json['price'],
      category: json['category'],
      quantity: json['quantity'],
      images: json['images'] != null
          ? List<Images>.from(json['images'].map((v) => Images.fromJson(v)))
          : null,
      tags: json['tags']?.cast<String>(),
      totalrating: json['totalrating'],
      ratings: json['ratings'] != null
          ? List<dynamic>.from(json['ratings']) // Adjusted to dynamic list
          : null,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      iV: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['slug'] = slug;
    data['description'] = description;
    data['price'] = price;
    data['category'] = category;
    data['quantity'] = quantity;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['tags'] = tags;
    data['totalrating'] = totalrating;
    if (ratings != null) {
      data['ratings'] = ratings; // No need for conversion here
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['asset_id'] = assetId;
    data['public_id'] = publicId;
    return data;
  }
}

class PaymentIntent {
  String? id;
  String? method;
  int? amount;
  String? status;
  int? created;
  String? currency;

  PaymentIntent({
    this.id,
    this.method,
    this.amount,
    this.status,
    this.created,
    this.currency,
  });

  factory PaymentIntent.fromJson(Map<String, dynamic> json) {
    return PaymentIntent(
      id: json['id'],
      method: json['method'],
      amount: json['amount'],
      status: json['status'],
      created: json['created'],
      currency: json['currency'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['method'] = method;
    data['amount'] = amount;
    data['status'] = status;
    data['created'] = created;
    data['currency'] = currency;
    return data;
  }
}

class Orderby {
  String? sId;
  String? name;
  String? email;
  String? id;

  Orderby({
    this.sId,
    this.name,
    this.email,
    this.id,
  });

  factory Orderby.fromJson(Map<String, dynamic> json) {
    return Orderby(
      sId: json['_id'],
      name: json['name'],
      email: json['email'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['id'] = id;
    return data;
  }
}
