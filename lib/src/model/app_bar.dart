class AppbarData {
  int? size;
  String? extension;
  String? type;
  String? url;

  AppbarData({this.size, this.extension, this.type, this.url});

  AppbarData.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    extension = json['extension'];
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['extension'] = this.extension;
    data['type'] = this.type;
    data['url'] = this.url;
    return data;
  }
}
