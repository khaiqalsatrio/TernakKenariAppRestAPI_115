import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:project_115/data/model/response/burung_semua_tersedia_model.dart';
import 'package:project_115/service/service_http_client.dart';

class GetAllBurungTersediaRepository {
  final ServiceHttpClient httpClient;

  GetAllBurungTersediaRepository(this.httpClient);

  Future<Either<String, BurungSemuaTersediaModel>>
  getAllBurungTersedia() async {
    try {
      final response = await httpClient.get("buyer/burung-semua-tersedia");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final burungTersediaResponse = BurungSemuaTersediaModel.fromJson(
          jsonResponse,
        );
        return Right(burungTersediaResponse);
      } else {
        final errorMessage = json.decode(response.body);
        return Left(
          errorMessage['message'] ?? 'Terjadi kesalahan tidak dikenal',
        );
      }
    } catch (e) {
      if (e is SocketException) {
        return Left("Tidak ada koneksi internet");
      } else if (e is HttpException) {
        return Left("Kesalahan HTTP: ${e.message}");
      } else if (e is FormatException) {
        return Left("Format respons tidak valid");
      } else {
        return Left("Terjadi kesalahan tidak terduga: $e");
      }
    }
  }
}
