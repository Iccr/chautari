class Amenities {
  int id;
  String name;
  int tag;

  Amenities({this.id, this.name, this.tag});

  Amenities.fromJson(Map<String, dynamic> json) {
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

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Amenities &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          tag == other.tag;

  @override
  int get hashCode => tag.hashCode;
}
