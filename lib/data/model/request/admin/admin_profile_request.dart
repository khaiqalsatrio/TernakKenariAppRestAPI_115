import 'dart:convert';

class AdminRequestModel {
  final String? name;

  AdminRequestModel({this.name});

  factory AdminRequestModel.fromJson(String str) =>
      AdminRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AdminRequestModel.fromMap(Map<String, dynamic> json) =>
      AdminRequestModel(name: json["name"]);

  Map<String, dynamic> toMap() => {"name": name};
}
