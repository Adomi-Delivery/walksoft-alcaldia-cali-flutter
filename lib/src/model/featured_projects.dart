class FeaturedProjects {
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
  String? components;
  String? cost;
  String? estimatedCost;
  String? type;
  String? coverImage;
  String? createdAt;
  String? updatedAt;

  FeaturedProjects(
      {this.id,
      this.name,
      this.userId,
      this.leaderId,
      this.typeId,
      this.dimensionId,
      this.programId,
      this.officeId,
      this.startDate,
      this.realStartDate,
      this.endDate,
      this.realEndDate,
      this.status,
      this.objectives,
      this.description,
      this.cityId,
      this.address,
      this.latitude,
      this.longitude,
      this.components,
      this.cost,
      this.estimatedCost,
      this.type,
      this.coverImage,
      this.createdAt,
      this.updatedAt});

  FeaturedProjects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userId = json['user_id'];
    leaderId = json['leader_id'];
    typeId = json['type_id'];
    dimensionId = json['dimension_id'];
    programId = json['program_id'];
    officeId = json['office_id'];
    startDate = json['start_date'];
    realStartDate = json['real_start_date'];
    endDate = json['end_date'];
    realEndDate = json['real_end_date'];
    status = json['status'];
    objectives = json['objectives'];
    description = json['description'];
    cityId = json['city_id'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    components = json['components'];
    cost = json['cost'];
    estimatedCost = json['estimated_cost'];
    type = json['type'];
    coverImage = json['cover_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['leader_id'] = this.leaderId;
    data['type_id'] = this.typeId;
    data['dimension_id'] = this.dimensionId;
    data['program_id'] = this.programId;
    data['office_id'] = this.officeId;
    data['start_date'] = this.startDate;
    data['real_start_date'] = this.realStartDate;
    data['end_date'] = this.endDate;
    data['real_end_date'] = this.realEndDate;
    data['status'] = this.status;
    data['objectives'] = this.objectives;
    data['description'] = this.description;
    data['city_id'] = this.cityId;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['components'] = this.components;
    data['cost'] = this.cost;
    data['estimated_cost'] = this.estimatedCost;
    data['type'] = this.type;
    data['cover_image'] = this.coverImage;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
