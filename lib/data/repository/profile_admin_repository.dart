import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_115/data/model/response/admin_profile_response_model.dart';
import 'package:project_115/service/service_http_client.dart';

class ProfileAdminRepository {
  final ServiceHttpClient _serviceHttpClient;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  ProfileAdminRepository(this._serviceHttpClient);

  Future<Either<String, AdminProfileResponseModel>> addProfile(
    AdminProfileResponseModel requestModel,
  ) async {
    try {
      final response = await _serviceHttpClient.postWithToken(
        "admin/profile",
        requestModel.toMap(),
      );
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 201) {
        final profileResponse = AdminProfileResponseModel.fromMap(jsonResponse);
        log("Add Admin Profile Success: ${profileResponse.message}");
        return Right(profileResponse);
      } else {
        return Left(
          "Failed to add profile. Status code: ${response.statusCode}",
        );
      }
    } catch (e) {
      log("Error in adding profile: $e");
      return Left("An error occurred while adding profile: $e");
    }
  }

  Future<Either<String, AdminProfileResponseModel>> updateProfile(
    AdminProfileResponseModel requestModel,
  ) async {
    try {
      final response = await _serviceHttpClient.get("admin/profile");
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        final profileResponse = AdminProfileResponseModel.fromMap(jsonResponse);
        log("Update Admin Profile Success: ${profileResponse.message}");
        return Right(profileResponse);
      } else {
        log("Get Admin Profile Failed: ${jsonResponse['message']}");
        return Left(
          "Failed to update profile. Status code: ${response.statusCode}",
        );
      }
    } catch (e) {
      log("Error in updating profile: $e");
      return Left("An error occurred while updating profile: $e");
    }
  }
}
