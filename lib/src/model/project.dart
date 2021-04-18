class Project {
  String idProject;
  String name;
  String description;
  String location;
  String costs;
  String components;
  String startDate;
  String endDate;
  bool status;
  String urlImage;

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
    components = json["components"].toString();
    String temp = json["status"].toString();

    if (temp == "Activo") {
      status = true;
    } else {
      status = false;
    }
  }
}
