import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:project_115/data/model/request/admin/posting_jual_request_model.dart';
import 'package:project_115/data/model/response/burung_semua_tersedia_model.dart';

import 'package:project_115/data/model/response/get_all_burung_response_model.dart';
import 'package:project_115/service/service_http_client.dart';

class PostingRepository {
  final ServiceHttpClient _serviceHttpClient;

  PostingRepository(this._serviceHttpClient);

  Future<Either<String, BurungSemuaTersediaModel>> addPostBurung(
    PostingJualRequestModel requestModel,
  ) async {
    try {
      final response = await _serviceHttpClient.postWithToken(
        'admin/posting-jual',
        requestModel.toJson() as Map<String, dynamic>,
      );
      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 201) {
        final profileResponse = BurungSemuaTersediaModel.fromJson(jsonResponse);
        log("Add Burung successful: ${profileResponse.message}");
        return Right(profileResponse);
      } else {
        log("Add burung failed: ${jsonResponse['message']}");
        return Left(jsonResponse['message'] ?? 'Add burung failed');
      }
    } catch (e) {
      log("Error in Add burung: $e");
      return Left("An error occurred while posting burung: $e");
    }
  }

  Future<Either<String, GetAllBurungModel>> getAllBurung() async {
    try {
      final response = await _serviceHttpClient.get("admin/burung-semua");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final getAllBurung = GetAllBurungModel.fromJson(jsonResponse);
        return Right(getAllBurung);
      } else {
        final jsonResponse = json.decode(response.body);
        return Left(jsonResponse['message'] ?? 'Get all burung failed');
      }
    } catch (e) {
      return Left("An error occurred while getting all burung: $e");
    }
  }
}
