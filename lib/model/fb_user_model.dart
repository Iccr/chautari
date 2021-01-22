class FbUserModel {
  String name;
  String firstName;
  String lastName;
  String email;
  String picture;
  String id;
  FbError error;

  FbUserModel(
      {this.name,
      this.firstName,
      this.lastName,
      this.email,
      this.picture,
      this.id,
      this.error});

  FbUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    if (json['picture'] != null &&
        json['picture']['data'] != null &&
        json['picture']['data']['url'] != null) {
      picture = json['picture']['data']['url'];
    }

    id = json['id'];
    error = json['error'] != null ? new FbError.fromJson(json['error']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    if (this.picture != null) {
      data['picture'] = this.picture;
    }
    data['id'] = this.id;
    if (this.error != null) {
      data['error'] = this.error.toJson();
    }
    return data;
  }
}

class FbError {
  String message;
  String type;

  FbError({this.message, this.type});

  FbError.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['type'] = this.type;
    return data;
  }
}
