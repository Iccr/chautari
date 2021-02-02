class Parking {
  int id;
  String name;
  int tag;

  Parking({this.id, this.name, this.tag});

  Parking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['tag'] = this.tag;
    return data;
  }
}
