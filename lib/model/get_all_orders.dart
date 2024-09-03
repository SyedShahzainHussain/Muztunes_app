class GetAllOrder {
  String? sId;
  List<Products>? products;
  PaymentIntent? paymentIntent;
  String? orderStatus;
  Orderby? orderby;
  String? createdAt;
  String? updatedAt;
  int? iV;

  GetAllOrder({
    this.sId,
    this.products,
    this.paymentIntent,
    this.orderStatus,
    this.orderby,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  GetAllOrder.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    paymentIntent = json['paymentIntent'] != null
        ? PaymentIntent.fromJson(json['paymentIntent'])
        : null;
    orderStatus = json['orderStatus'];
    orderby = json['orderby'] != null ? Orderby.fromJson(json['orderby']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
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
  int? price;
  String? sId;
  String? article;

  Products({
    this.product,
    this.count,
    this.price,
    this.sId,
    this.article,
  });

  Products.fromJson(Map<String, dynamic> json) {
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
    count = json['count'];
    price = json['price'];
    sId = json['_id'];
    article = json['article'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['count'] = count;
    data['price'] = price;
    data['_id'] = sId;
    data['article'] = article;
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
  String? information;
  int? quantity;
  List<String>? images;
  List<String>? tags;
  String? totalrating;
  String? type;
  List<Rating>? ratings; // Changed from List<Null> to List<Rating>
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
  });

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    price = json['price'];
    category = json['category'];
    information = json['information'];
    quantity = json['quantity'];
    images = json['images']?.cast<String>();
    tags = json['tags']?.cast<String>();
    totalrating = json['totalrating'];
    type = json['type'];
    if (json['ratings'] != null) {
      ratings = <Rating>[];
      json['ratings'].forEach((v) {
        ratings!.add(Rating.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
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
      data['ratings'] = ratings!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Rating {
  String? userId; // Assuming there's a user ID associated with the rating
  double? value; // Assuming ratings are numeric (e.g., 4.5)

  Rating({
    this.userId,
    this.value,
  });

  Rating.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['value'] = value;
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

  PaymentIntent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    method = json['method'];
    amount = json['amount'];
    status = json['status'];
    created = json['created'];
    currency = json['currency'];
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

  Orderby.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    id = json['id'];
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
