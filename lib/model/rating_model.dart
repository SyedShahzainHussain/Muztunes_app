class RatingModel {
  List<Ratings>? ratings;

  RatingModel({this.ratings});

  RatingModel.fromJson(Map<String, dynamic> json) {
    if (json['ratings'] != null) {
      ratings = <Ratings>[];
      json['ratings'].forEach((v) {
        ratings!.add(Ratings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ratings != null) {
      data['ratings'] = ratings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ratings {
  int? star;
  String? comment;
  Postedby? postedby;

  Ratings({this.star, this.comment, this.postedby});

  Ratings.fromJson(Map<String, dynamic> json) {
    star = json['star'];
    comment = json['comment'];
    postedby =
        json['postedby'] != null ? Postedby.fromJson(json['postedby']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['star'] = star;
    data['comment'] = comment;
    if (postedby != null) {
      data['postedby'] = postedby!.toJson();
    }
    return data;
  }
}

class Postedby {
  String? sId;
  String? name;
  String? email;
  String? image;
  String? id;

  Postedby({this.sId, this.name, this.email, this.image, this.id});

  Postedby.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['image'] = image;
    data['id'] = id;
    return data;
  }
}
