import 'dart:convert';

LoginRequestModel loginRequestModelFromMap(String str) =>
    LoginRequestModel.fromMap(json.decode(str));

String loginRequestModelToMap(LoginRequestModel data) =>
    json.encode(data.toMap());

class LoginRequestModel {
  String email;
  String password;

  LoginRequestModel({required this.email, required this.password});

  factory LoginRequestModel.fromMap(Map<String, dynamic> json) =>
      LoginRequestModel(email: json["email"], password: json["password"]);

  Map<String, dynamic> toMap() => {"email": email, "password": password};
}
