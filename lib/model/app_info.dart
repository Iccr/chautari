import 'package:chautari/model/error.dart';

class AppinfoResponseModel {
  AppinfoModel data;
  List<ApiError> errors;

  AppinfoResponseModel({this.data});

  AppinfoResponseModel.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? new AppinfoModel.fromJson(json['data']) : null;

    if (json['error'] != null) {
      errors = new List<ApiError>();
      json['error'].forEach((v) {
        errors.add(new ApiError.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }

    if (this.errors != null) {
      data['errors'] = this.errors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AppinfoModel {
  List<Amenities> amenities;
  List<Districts> districts;
  List<Parking> parkings;
  List<Waters> waters;

  AppinfoModel({this.amenities, this.districts, this.parkings, this.waters});

  AppinfoModel.fromJson(Map<String, dynamic> json) {
    if (json['amenities'] != null) {
      amenities = new List<Amenities>();
      json['amenities'].forEach((v) {
        amenities.add(new Amenities.fromJson(v));
      });
    }
    if (json['districts'] != null) {
      districts = new List<Districts>();
      json['districts'].forEach((v) {
        districts.add(new Districts.fromJson(v));
      });
    }
    if (json['parkings'] != null) {
      parkings = new List<Parking>();
      json['parkings'].forEach((v) {
        parkings.add(new Parking.fromJson(v));
      });
    }
    if (json['waters'] != null) {
      waters = new List<Waters>();
      json['waters'].forEach((v) {
        waters.add(new Waters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.amenities != null) {
      data['amenities'] = this.amenities.map((v) => v.toJson()).toList();
    }
    if (this.districts != null) {
      data['districts'] = this.districts.map((v) => v.toJson()).toList();
    }
    if (this.parkings != null) {
      data['parkings'] = this.parkings.map((v) => v.toJson()).toList();
    }
    if (this.waters != null) {
      data['waters'] = this.waters.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

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
}

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

class Waters {
  String name;
  int value;

  Waters({this.name, this.value});

  Waters.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}

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
