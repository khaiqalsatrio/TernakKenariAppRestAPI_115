import 'dart:convert';

RegisterRequestModel registerRequestModelFromMap(String str) =>
    RegisterRequestModel.fromMap(json.decode(str));

String registerRequestModelToMap(RegisterRequestModel data) =>
    json.encode(data.toMap());

class RegisterRequestModel {
  String email;
  String password;

  RegisterRequestModel({required this.email, required this.password});

  factory RegisterRequestModel.fromMap(Map<String, dynamic> json) =>
      RegisterRequestModel(email: json["email"], password: json["password"]);

  Map<String, dynamic> toMap() => {"email": email, "password": password};
}
