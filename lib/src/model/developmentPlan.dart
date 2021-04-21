class DevelopmentPlan {
  String title;
  String banner;
  String url;

  DevelopmentPlan({this.title, this.banner, this.url});

  DevelopmentPlan.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    banner = json['banner'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['banner'] = this.banner;
    data['url'] = this.url;
    return data;
  }
}
