import 'dart:convert';

class PostingJualRequestModel {
  final int? burungId;
  final String? burungType;
  final int? harga;
  final String? deskripsi;

  PostingJualRequestModel({
    this.burungId,
    this.burungType,
    this.harga,
    this.deskripsi,
  });

  factory PostingJualRequestModel.fromJson(String str) =>
      PostingJualRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostingJualRequestModel.fromMap(Map<String, dynamic> json) =>
      PostingJualRequestModel(
        burungId: json["burung_id"],
        burungType: json["burung_type"],
        harga: json["harga"],
        deskripsi: json["deskripsi"],
      );

  Map<String, dynamic> toMap() => {
    "burung_id": burungId,
    "burung_type": burungType,
    "harga": harga,
    "deskripsi": deskripsi,
  };
}
