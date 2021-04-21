class File {
  String fileName;
  String ext;
  String url;

  File();

  File.fromJsonMap(Map<String, dynamic> json) {
    fileName = json['filename']?.toString();
    ext = json['extension']?.toString();
    url = json['url']?.toString();
  }
}
