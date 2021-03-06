class Schedule {
  String? id;
  late String name;
  String? description;
  late String startDateFormat;
  late String starHourFormat;
  String? endDateFormat;
  String? endHourFormat;

  Schedule();

  Schedule.fromJsonToMap(Map<String, dynamic> json) {
    id = json["id"].toString();
    name = json["name"].toString();
    description = json["description"].toString();
    startDateFormat = json["start_date_format"].toString();
    starHourFormat = json["start_hour_format"].toString();
    endDateFormat = json["end_date_format"].toString();
    endHourFormat = json["end_hour_format"].toString();
  }
}
