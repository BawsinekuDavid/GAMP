import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:logger/logger.dart';

class AuthService {
  // Logger instance
  final Logger _logger = Logger();

  // Consider moving sensitive information to a secure location (e.g., environment variables)
  final String _clientId = 'gamp';
  // ignore: unused_field
  final String _clientSecret = 'wNngFGjk19EdHY3TNTrToCkzrvKLCgvC';

  final String _tokenEndpoint =
      'http://192.168.234.130:8080/realms/gamp/protocol/openid-connect/token';

 Future<Map<String, dynamic>?> login(
    String email, String password, BuildContext context) async {
  try {
    _logger.i("Sending login request...");

    final body = {
      'grant_type': 'client_credentials',
      'client_id': _clientId,
      'username': email,
      'password': password,
    };

    final response = await http.post(
      Uri.parse(_tokenEndpoint),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: body,
    );

    _logger.d("Response status: ${response.statusCode}");
    _logger.d("Response body: ${response.body}");

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final accessToken = responseData['access_token'];

      if (accessToken != null && accessToken.isNotEmpty) {
        if (JwtDecoder.isExpired(accessToken)) {
          _logger.e("Error: Token is expired.");
          return null;
        }

        final decodedToken = JwtDecoder.decode(accessToken);
        _logger.i("Token decoded successfully: $decodedToken");

        return decodedToken;
      } else {
        _logger.e("Access token missing.");
      }
    } else {
      _logger.e("Login failed: ${response.statusCode}");
      _logger.e("Response body: ${response.body}");
    }
  } catch (e) {
    _logger.e("Login error: $e");
  }

  return null;
}


  // Optional: Test API connection (if needed)
  Future<void> testApiConnection() async {
    try {
      final response = await http.get(Uri.parse("http://192.168.234.130:8080/api"));
      _logger.d("API Connection Test Status: ${response.statusCode}");
    } catch (e) {
      _logger.e("API Connection Error: $e");
    }
  }
}
