// class ApiError {
//   List<Errors> errors;

//   ApiError({this.errors});

//   ApiError.fromJson(Map<String, dynamic> json) {
//     if (json['errors'] != null) {
//       errors = new List<Errors>();
//       json['errors'].forEach((v) {
//         errors.add(new Errors.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
// final Map<String, dynamic> data = new Map<String, dynamic>();
// if (this.errors != null) {
//   data['errors'] = this.errors.map((v) => v.toJson()).toList();
// }
// return data;
//   }
// }

class ApiError {
  String name;
  String value;

  ApiError({this.name, this.value});

  ApiError.fromJson(Map<String, dynamic> json) {
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
