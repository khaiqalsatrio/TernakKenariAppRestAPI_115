import 'dart:convert';

LoginResponseModel loginResponseModelFromMap(String str) =>
    LoginResponseModel.fromMap(json.decode(str));

String loginResponseModelToMap(LoginResponseModel data) =>
    json.encode(data.toMap());

class LoginResponseModel {
  String message;
  int statusCode;
  Data data;

  LoginResponseModel({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory LoginResponseModel.fromMap(Map<String, dynamic> json) =>
      LoginResponseModel(
        message: json["message"],
        statusCode: json["status_code"],
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
    "message": message,
    "status_code": statusCode,
    "data": data.toMap(),
  };
}

class Data {
  int id;
  String name;
  String email;
  String role;
  String token;

  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.token,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    role: json["role"],
    token: json["token"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "email": email,
    "role": role,
    "token": token,
  };
}
