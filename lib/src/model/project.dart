import 'package:walksoft_alcaldia_cali_flutter/src/model/timeline.dart';

class Project {
  String? idProject;
  String? name;
  String? description;
  String? location;
  late String costs;
  List<String> components = [];
  late String startDate;
  late String endDate;
  late bool status;
  late String urlImage;
  late String latitude;
  late String longitude;
  late List<TimeLine> timeline;

  Project();

  Project.fromJsonMap(Map<String, dynamic> json) {
    idProject = json["id"].toString();
    name = json["name"].toString();
    description = json["description"].toString();
    costs = json["cost"].toString();
    startDate = json["start_date"].toString();
    endDate = json["end_date"].toString();
    urlImage = json["cover_image"].toString();
    location = json["address"].toString();
    latitude = json["latitude"].toString();
    longitude = json["longitude"].toString();

    String temp = json["status"].toString();

    if (temp == "1") {
      status = true;
    } else {
      status = false;
    }

    List<dynamic>? temp2 = json["components"];
    if (temp2 != null) {
      for (var item in temp2) {
        components.add(item);
      }
    }

    var list = json['timeline'] as List?;

    if (list != null) {
      timeline = list.map((i) => TimeLine.fromJsonMap(i)).toList();
    }
  }
}
