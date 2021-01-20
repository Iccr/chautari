class ApiError {
  String cause;
  String detail;
  String code;
  String pointer;

  ApiError({this.cause, this.detail, this.code, this.pointer});

  ApiError.fromJson(Map<String, dynamic> json) {
    cause = json['cause'];
    detail = json['detail'];
    code = json['code'];
    pointer = json['pointer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cause'] = this.cause;
    data['detail'] = this.detail;
    data['code'] = this.code;
    data['pointer'] = this.pointer;
    return data;
  }
}
