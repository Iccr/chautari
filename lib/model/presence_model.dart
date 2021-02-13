class PresenceModel {
  List<Metas> metas;

  PresenceModel({this.metas});

  PresenceModel.fromJson(Map<String, dynamic> json) {
    if (json['metas'] != null) {
      metas = new List<Metas>();
      json['metas'].forEach((v) {
        metas.add(new Metas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.metas != null) {
      data['metas'] = this.metas.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Metas {
  String phxRef;
  bool typing;
  int userId;

  Metas({this.phxRef, this.typing, this.userId});

  Metas.fromJson(Map<String, dynamic> json) {
    phxRef = json['phx_ref'];
    typing = json['typing'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phx_ref'] = this.phxRef;
    data['typing'] = this.typing;
    data['user_id'] = this.userId;
    return data;
  }
}
