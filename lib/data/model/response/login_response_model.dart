import 'dart:convert';

LoginResponseModel loginResponseModelFromMap(String str) =>
    LoginResponseModel.fromMap(json.decode(str));

String loginResponseModelToMap(LoginResponseModel data) =>
    json.encode(data.data);

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
}

class Data {
  int id;
  String name;
  String email;
  String role;
  String token;
  String address;
  String phone;

  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.token,
    required this.address,
    required this.phone,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    role: json["role"],
    token: json["token"],
    address: json["address"] ?? '',
    phone: json["phone"] ?? '',
  );
}
