class Sites {
  int? id;
  String? name;
  String? description;
  String? address;
  String? latitude;
  String? longitude;
  int? status;
  List<Files>? files;
  String? createdAt;
  String? updatedAt;
  String? category;

  Sites(
      {this.id,
      this.name,
      this.description,
      this.address,
      this.latitude,
      this.longitude,
      this.status,
      this.files,
      this.createdAt,
      this.updatedAt,
      this.category});

  Sites.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    status = json['status'];
    category = json['category'];
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(new Files.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['status'] = this.status;
    data['category'] = this.category;
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Files {
  int? id;
  int? siteId;
  String? filename;
  String? description;
  int? size;
  String? path;
  String? extension;
  String? mimeType;
  String? createdAt;
  String? updatedAt;

  Files(
      {this.id,
      this.siteId,
      this.filename,
      this.description,
      this.size,
      this.path,
      this.extension,
      this.mimeType,
      this.createdAt,
      this.updatedAt});

  Files.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siteId = json['site_id'];
    filename = json['filename'];
    description = json['description'];
    size = json['size'];
    path = json['path'];
    extension = json['extension'];
    mimeType = json['mime_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['site_id'] = this.siteId;
    data['filename'] = this.filename;
    data['description'] = this.description;
    data['size'] = this.size;
    data['path'] = this.path;
    data['extension'] = this.extension;
    data['mime_type'] = this.mimeType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
