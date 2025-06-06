import 'dart:convert';

class BuyerProfileResponseModel {
  final int? burungId;
  final String? burungType;
  final int? harga;
  final String? deskripsi;

  BuyerProfileResponseModel({
    this.burungId,
    this.burungType,
    this.harga,
    this.deskripsi,
  });

  factory BuyerProfileResponseModel.fromJson(String str) =>
      BuyerProfileResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BuyerProfileResponseModel.fromMap(Map<String, dynamic> json) =>
      BuyerProfileResponseModel(
        burungId: json["burung_id"],
        burungType: json["burung_type"],
        harga: json["harga"],
        deskripsi: json["deskripsi"],
      );

  get data => null;

  Map<String, dynamic> toMap() => {
    "burung_id": burungId,
    "burung_type": burungType,
    "harga": harga,
    "deskripsi": deskripsi,
  };
}
