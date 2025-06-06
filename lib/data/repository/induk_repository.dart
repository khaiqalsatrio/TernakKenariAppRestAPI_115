import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:project_115/data/model/request/admin/induk_request_model.dart';
import 'package:project_115/data/model/response/get_all_induk_response.dart';
import 'package:project_115/service/service_http_client.dart';

class IndukRepository {
  final ServiceHttpClient _serviceHttpClient;

  IndukRepository(this._serviceHttpClient);

  Future<Either<String, GetIndukById>> addInduk(
    IndukRequestModel requestModel,
  ) async {
    try {
      final response = await _serviceHttpClient.postWithToken(
        "admin/induk",
        requestModel.toJson() as Map<String, dynamic>,
      );
      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        final indukResponse = GetIndukById.fromJson(jsonResponse);
        log("Add induk Success: ${indukResponse.message}");
        return Right(indukResponse);
      } else {
        return Left("Failed to add induk. Status code: ${response.statusCode}");
      }
    } catch (e) {
      log("Error in adding induk: $e");
      return Left("An error occurred while adding induk: $e");
    }
  }

  Future<Either<String, GetAllIndukModel>> getAllInduk() async {
    try {
      final response = await _serviceHttpClient.get("induk");
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        final indukResponse = GetAllIndukModel.fromJson(jsonResponse);
        log("Get induk Success: ${indukResponse.message}");
        return Right(indukResponse);
      } else {
        return Left(
          "Failed to get induk data. Status code: ${response.statusCode}",
        );
      }
    } catch (e) {
      log("Error in getting induk: $e");
      return Left("An error occurred while getting induk: $e");
    }
  }
}
