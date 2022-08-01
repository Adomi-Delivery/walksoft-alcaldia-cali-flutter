class Notice {
  int? id;
  int? projectId;
  int? statusId;
  int? userId;
  String? title;
  String? content;
  String? date;
  String? coverImage;
  List<Files>? files;
  String? type;
  String? createdAt;
  String? updatedAt;

  Notice(
      {this.id,
      this.projectId,
      this.statusId,
      this.userId,
      this.title,
      this.content,
      this.date,
      this.coverImage,
      this.files,
      this.type,
      this.createdAt,
      this.updatedAt});

  Notice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['project_id'];
    statusId = json['status_id'];
    userId = json['user_id'];
    title = json['title'];
    content = json['content'];
    date = json['date'];
    coverImage = json['cover_image'];
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(new Files.fromJson(v));
      });
    }
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['project_id'] = this.projectId;
    data['status_id'] = this.statusId;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['content'] = this.content;
    data['date'] = this.date;
    data['cover_image'] = this.coverImage;
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Files {
  int? id;
  int? newsId;
  String? route;
  String? filename;
  int? size;
  String? extension;
  String? mimeType;
  String? description;
  String? createdAt;
  String? updatedAt;

  Files(
      {this.id,
      this.newsId,
      this.route,
      this.filename,
      this.size,
      this.extension,
      this.mimeType,
      this.description,
      this.createdAt,
      this.updatedAt});

  Files.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    newsId = json['news_id'];
    route = json['route'];
    filename = json['filename'];
    size = json['size'];
    extension = json['extension'];
    mimeType = json['mime_type'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['news_id'] = this.newsId;
    data['route'] = this.route;
    data['filename'] = this.filename;
    data['size'] = this.size;
    data['extension'] = this.extension;
    data['mime_type'] = this.mimeType;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
