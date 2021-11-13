import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

class LoginResponse {
  bool success;
  int statusCode;
  String code;
  String message;
  Data data;
  LoginResponse({
    this.success,
    this.statusCode,
    this.code,
    this.message,
    this.data,
  });
  LoginResponse.fromJson(Map<String, dynamic> json) {
    print(json['data'].runtimeType);
    success = json['success'];
    statusCode = json['statusCode'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['statusCode'] = this.statusCode;
    data['firstName'] = this.code;
    data['message'] = this.message;
    data['data'] = this.data;

    return data;
  }
}

class Data {
  String id;
  String email;
  String firstName;
  String lastName;
  String nicename;
  String token;
  String displayName;

  Data({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.displayName,
    this.nicename,
    this.token,
  });
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    email = json['email'];
    firstName = json['firstName'];
    displayName = json['displayName'];
    nicename = json['nicename'];
    token = json['token'];
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = id;
    map['email'] = email;
    map['firstName'] = firstName;
    map['displayName'] = displayName;
    map['nicename'] = nicename;
    map['token'] = token;
    return map;
  }
}
