class FeaturedProjects {
  int id;
  int order;
  String name;
  String image;

  FeaturedProjects({this.id, this.order, this.name, this.image});

  FeaturedProjects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    order = json['order'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order'] = this.order;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}
