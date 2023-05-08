import 'dart:ffi';

import 'package:walksoft_alcaldia_cali_flutter/src/model/timeline.dart';

class Project {
  int? id;
  String? name;
  int? userId;
  int? leaderId;
  int? typeId;
  int? dimensionId;
  int? programId;
  int? officeId;
  String? startDate;
  String? realStartDate;
  String? endDate;
  String? realEndDate;
  int? status;
  String? objectives;
  String? description;
  int? cityId;
  String? address;
  String? latitude;
  String? longitude;
  List<String>? components = [];
  String? cost;
  String? estimatedCost;
  String? type;
  String? coverImage;
  String? createdAt;
  String? updatedAt;
  String? location;
  String? costs;
  String? urlImage;
  List<TimeLine>? timeline;
  Project();

  Project.fromJsonMap(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"].toString();
    description = json["description"].toString();
    costs = json["cost"].toString();
    startDate = json["start_date"].toString();
    endDate = json["end_date"].toString();
    location = json["address"].toString();
    latitude = json["latitude"].toString();
    longitude = json["longitude"].toString();
    userId = json['user_id'];
    leaderId = json['leader_id'];
    typeId = json['type_id'];
    dimensionId = json['dimension_id'];
    programId = json['program_id'];
    officeId = json['office_id'];
    realStartDate = json['real_start_date'];
    realEndDate = json['real_end_date'];
    status = json['status'];
    objectives = json['objectives'];
    description = json['description'];
    cityId = json['city_id'];
    address = json['address'];
    components = json['components'];
    cost = json['cost'];
    estimatedCost = json['estimated_cost'];
    type = json['type'];
    coverImage = json['cover_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

    String temp = json["status"].toString();

    if (temp == "1") {
      status = 1;
    } else {
      status = 0;
    }

    List<dynamic>? temp2 = json["components"];
    if (temp2 != null) {
      for (var item in temp2) {
        components!.add(item);
      }
    }

    var list = json['timeline'] as List?;

    if (list != null) {
      timeline = list.map((i) => TimeLine.fromJsonMap(i)).toList();
    }
  }
}
