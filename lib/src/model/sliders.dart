class Sliders {
  int? id;
  List<Images>? images;

  Sliders({this.id, this.images});

  Sliders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  int? id;
  int? sliderId;
  String? image;
  String? link;
  String? filename;
  int? size;
  String? extension;
  String? mimeType;
  String? createdAt;
  String? updatedAt;
  String? description;

  Images({
    this.id,
    this.sliderId,
    this.image,
    this.link,
    this.filename,
    this.size,
    this.extension,
    this.mimeType,
    this.createdAt,
    this.updatedAt,
    this.description,
  });

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sliderId = json['slider_id'];
    image = json['image'];
    link = json['link'];
    filename = json['filename'];
    size = json['size'];
    extension = json['extension'];
    mimeType = json['mime_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slider_id'] = this.sliderId;
    data['image'] = this.image;
    data['link'] = this.link;
    data['filename'] = this.filename;
    data['size'] = this.size;
    data['extension'] = this.extension;
    data['mime_type'] = this.mimeType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['description'] = this.description;
    return data;
  }
}
