class AppConfig {
  String androidVersion;
  String iosVersion;
  bool forceUpdate;

  AppConfig({this.androidVersion, this.iosVersion, this.forceUpdate});

  AppConfig.fromJson(Map<String, dynamic> json) {
    androidVersion = json['android_version'];
    iosVersion = json['force_update'];
    forceUpdate = json['ios_version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['android_version'] = this.androidVersion;
    data['ios_version'] = this.iosVersion;
    data['force_update'] = this.forceUpdate;
    return data;
  }
}

// class RoomType {
//   String name;
//   int value;

//   RoomType({this.name, this.value});

//   RoomType.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     value = json['value'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['value'] = this.value;
//     return data;
//   }
// }
