import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:project_115/data/model/request/buyer/buyer_profile_request_model.dart';
import 'package:project_115/data/model/response/buyer/buyer_profile_response_model.dart.dart';
import 'package:project_115/service/service_http_client.dart';

class ProfileBuyerRepository {
  final ServiceHttpClient _serviceHttpClient;

  ProfileBuyerRepository(this._serviceHttpClient);

  Future<Either<String, BuyerProfileResponseModel>> addProfileBuyer(
    BuyerProfileRequestModel requestModel,
  ) async {
    try {
      final response = await _serviceHttpClient.postWithToken(
        "buyer/profile",
        requestModel.toMap(), // gunakan toMap agar jadi Map<String, dynamic>
      );

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        final profileResponse = BuyerProfileResponseModel.fromJson(
          jsonResponse,
        );
        return Right(profileResponse);
      } else {
        final errorMessage = json.decode(response.body);
        return Left(
          errorMessage['message'] ?? 'Terjadi kesalahan tidak dikenal',
        );
      }
    } catch (e) {
      return Left("Terjadi kesalahan saat menambahkan profil: $e");
    }
  }

  Future<Either<String, BuyerProfileResponseModel>> getProfileBuyer() async {
    try {
      final response = await _serviceHttpClient.get("buyer/profile");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final profileResponse = BuyerProfileResponseModel.fromJson(
          jsonResponse,
        );
        if (kDebugMode) {
          print("Profile Response: $profileResponse");
        }
        return Right(profileResponse);
      } else {
        final errorMessage = json.decode(response.body);
        return Left(
          errorMessage['message'] ?? 'Terjadi kesalahan tidak dikenal',
        );
      }
    } catch (e) {
      return Left("Terjadi kesalahan saat mengambil profil: $e");
    }
  }
}
