class Districts {
  int id;
  String name;

  int state;

  Districts({this.id, this.name, this.state});

  Districts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    // if (json['rooms'] != null) {
    //   rooms = new List<Null>();
    //   json['rooms'].forEach((v) {
    //     rooms.add(new Null.fromJson(v));
    //   });
    // }
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    // if (this.rooms != null) {
    //   data['rooms'] = this.rooms.map((v) => v.toJson()).toList();
    // }
    data['state'] = this.state;
    return data;
  }
}
