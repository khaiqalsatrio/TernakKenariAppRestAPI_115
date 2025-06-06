import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ServiceHttpClient {
  final String baseUrl = 'http://10.0.2.2:8000/api/';
  final secureStorage = FlutterSecureStorage();

  //POST
  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse("$baseUrl$endpoint");

    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      throw Exception("POST request failed: $e");
    }
  }

  //GET
  Future<http.Response> get(String endpoint) async {
    final token = await secureStorage.read(key: "authToken");
    final url = Uri.parse("$baseUrl$endpoint");

    try {
      final response = await http.get(
        url,
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      return response;
    } catch (e) {
      throw Exception("GET request failed: $e");
    }
  }

  Future<http.Response> postWithToken(String url, dynamic body) async {
    final token = await secureStorage.read(key: "authToken");

    return http.post(
      Uri.parse(baseUrl + url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: body is String ? body : json.encode(body),
    );
  }
}
