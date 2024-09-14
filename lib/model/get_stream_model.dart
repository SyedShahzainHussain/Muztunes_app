class StreamModel {
  String? sId;
  String? videoId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  StreamModel({this.sId, this.videoId, this.createdAt, this.updatedAt, this.iV});

  StreamModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    videoId = json['videoId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['videoId'] = this.videoId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
