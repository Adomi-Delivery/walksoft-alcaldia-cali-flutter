import 'package:walksoft_alcaldia_cali_flutter/src/model/file.dart';

class TimeLine {
  String createdAt;
  String title;
  String details;
  String note;
  String user;
  List<File> files;

  TimeLine();

  TimeLine.fromJsonMap(Map<String, dynamic> json) {
    createdAt = json['created_at'].toString();
    title = json['title'].toString();
    details = json['details'].toString();
    note = json['note'].toString();
    user = json['user'].toString();

    var list = json['files'] as List;

    if (list != null) {
      files = list.map((i) => File.fromJsonMap(i)).toList();
    }
  }
}
