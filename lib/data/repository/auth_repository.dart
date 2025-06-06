import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:project_115/data/model/request/auth/login_request_model.dart';
import 'package:project_115/data/model/response/auth_response_model.dart';
import 'package:project_115/data/model/request/auth/register_request_model.dart';
import 'package:project_115/service/service_http_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepository {
  final ServiceHttpClient _serviceHttpClient;
  final secureStorage = FlutterSecureStorage();

  AuthRepository(this._serviceHttpClient);

  // Future<Either<String, LoginResponseModel>> login(
  //   LoginRequestModel requestModel,
  // ) async {
  //   try {
  //     final response = await _serviceHttpClient.post(
  //       "login",
  //       requestModel.toMap(),
  //     );

  //     if (kDebugMode) {
  //       print("Response body: ${response.body}");
  //     }

  //     final jsonResponse = json.decode(response.body);

  //     if (response.statusCode == 200) {
  //       final loginResponse = LoginResponseModel.fromMap(jsonResponse);
  //       await secureStorage.write(
  //         key: "authToken",
  //         value: loginResponse.data.token,
  //       );
  //       await secureStorage.write(
  //         key: "userRole",
  //         value: loginResponse.data.role,
  //       );
  //       return Right(loginResponse);
  //     } else {
  //       return Left(jsonResponse['message'] ?? 'Login failed');
  //     }
  //   } catch (e) {
  //     return Left("An error occurred during login: $e");
  //   }
  // }

  Future<Either<String, AuthResponseModel>> login(
    LoginRequestModel requestModel,
  ) async {
    try {
      final response = await _serviceHttpClient.postWithToken(
        'login',
        requestModel.toMap(),
      );
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        final authResponse = AuthResponseModel.fromMap(jsonResponse);
        if (authResponse.user?.token != null) {
          await secureStorage.write(
            key: "authToken",
            value: authResponse.user!.token!,
          );
          await secureStorage.write(
            key: "buyerRole",
            value: authResponse.user!.role ?? '',
          );
        }
        return Right(authResponse);
      } else {
        return Left(jsonResponse['message'] ?? 'Login failed');
      }
    } catch (e) {
      return Left("An error occured while logging in: $e");
    }
  }

  Future<Either<String, String>> register(
    RegisterRequestModel requestModel,
  ) async {
    try {
      final response = await _serviceHttpClient.postWithToken(
        "register",
        requestModel.toMap(),
      );
      if (kDebugMode) {
        print('Register status code: ${response.statusCode}');
      }
      if (kDebugMode) {
        print('Register response body: ${response.body}');
      } // <-- ini penting

      final jsonResponse = json.decode(response.body);
      final registerResponse = jsonResponse['message'];

      if (response.statusCode == 200) {
        return Right(registerResponse);
      } else {
        return Left(jsonResponse['message'] ?? 'Registration failed');
      }
    } catch (e) {
      return Left("An error occurred during registration: $e");
    }
  }
}
