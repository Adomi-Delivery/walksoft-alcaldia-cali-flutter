class Offices {
  String? id;
  String? name;

  Offices();
  Offices.createBasic({this.id, this.name});

  Offices.fromJsonMap(Map<String, dynamic> json) {
    id = json["id"].toString();
    name = json["name"].toString();
  }
}
