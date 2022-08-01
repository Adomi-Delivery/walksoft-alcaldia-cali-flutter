class ButtonsHome {
  int? id;
  String? parameter;
  String? route;
  String? createdAt;
  String? updatedAt;

  ButtonsHome(
      {this.id, this.parameter, this.route, this.createdAt, this.updatedAt});

  ButtonsHome.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parameter = json['parameter'];
    route = json['route'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parameter'] = this.parameter;
    data['route'] = this.route;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
