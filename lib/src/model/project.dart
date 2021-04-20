class Project {
  String idProject;
  String name;
  String description;
  String location;
  String costs;
  List<String> components = [];
  String startDate;
  String endDate;
  bool status;
  String urlImage;
  String latitude;
  String longitude;

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

    if (temp == "Activo") {
      status = true;
    } else {
      status = false;
    }

    List<dynamic> temp2 = json["components"];

    for (var item in temp2) {
      print(item);
      components.add(item);
    }
  }
}
