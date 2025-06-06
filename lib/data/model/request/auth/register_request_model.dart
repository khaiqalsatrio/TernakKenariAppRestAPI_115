import 'dart:convert';

RegisterRequestModel registerRequestModelFromMap(String str) =>
    RegisterRequestModel.fromMap(json.decode(str));

String registerRequestModelToMap(RegisterRequestModel data) =>
    json.encode(data.toMap());

class RegisterRequestModel {
  final String name;
  final String email;
  final String password;

  RegisterRequestModel({
    required this.name,
    required this.email,
    required this.password,
  });

  factory RegisterRequestModel.fromMap(Map<String, dynamic> json) =>
      RegisterRequestModel(
        name: json["name"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toMap() => {
    "username": name, // Biarkan tetap 'username'
    "email": email,
    "password": password,
  };
}
