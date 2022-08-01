class Gallery {
  List<General>? general;
  List<Projects>? projects;
  List<Programs>? programs;
  List<Sites>? sites;

  Gallery({this.general, this.projects, this.programs, this.sites});

  Gallery.fromJson(Map<String, dynamic> json) {
    if (json['general'] != null) {
      general = <General>[];
      json['general'].forEach((v) {
        general!.add(new General.fromJson(v));
      });
    }
    if (json['projects'] != null) {
      projects = <Projects>[];
      json['projects'].forEach((v) {
        projects!.add(new Projects.fromJson(v));
      });
    }
    if (json['programs'] != null) {
      programs = <Programs>[];
      json['programs'].forEach((v) {
        programs!.add(new Programs.fromJson(v));
      });
    }
    if (json['sites'] != null) {
      sites = <Sites>[];
      json['sites'].forEach((v) {
        sites!.add(new Sites.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.general != null) {
      data['general'] = this.general!.map((v) => v.toJson()).toList();
    }
    if (this.projects != null) {
      data['projects'] = this.projects!.map((v) => v.toJson()).toList();
    }
    if (this.programs != null) {
      data['programs'] = this.programs!.map((v) => v.toJson()).toList();
    }
    if (this.sites != null) {
      data['sites'] = this.sites!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class General {
  int? id;
  String? description;
  String? route;
  String? filename;
  int? size;
  String? extension;
  String? mimeType;
  int? status;
  String? createdAt;
  String? updatedAt;

  General(
      {this.id,
      this.description,
      this.route,
      this.filename,
      this.size,
      this.extension,
      this.mimeType,
      this.status,
      this.createdAt,
      this.updatedAt});

  General.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    route = json['route'];
    filename = json['filename'];
    size = json['size'];
    extension = json['extension'];
    mimeType = json['mime_type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['route'] = this.route;
    data['filename'] = this.filename;
    data['size'] = this.size;
    data['extension'] = this.extension;
    data['mime_type'] = this.mimeType;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Projects {
  int? id;
  String? name;
  String? type;
  String? coverImage;
  String? createdAt;
  String? updatedAt;

  Projects(
      {this.id,
      this.name,
      this.type,
      this.coverImage,
      this.createdAt,
      this.updatedAt});

  Projects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    coverImage = json['cover_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['cover_image'] = this.coverImage;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Programs {
  int? id;
  String? name;
  String? coverImage;
  String? createdAt;
  String? updatedAt;

  Programs(
      {this.id, this.name, this.coverImage, this.createdAt, this.updatedAt});

  Programs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    coverImage = json['cover_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['cover_image'] = this.coverImage;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Sites {
  int? id;
  String? name;
  Files? files;
  String? createdAt;
  String? updatedAt;

  Sites({this.id, this.name, this.files, this.createdAt, this.updatedAt});

  Sites.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    files = json['files'] != null ? new Files.fromJson(json['files']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.files != null) {
      data['files'] = this.files!.toJson();
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
