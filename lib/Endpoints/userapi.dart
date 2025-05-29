import 'dart:convert';
import 'package:http/http.dart' as http;
 
import 'package:gmarket_app/models/user_model.dart';

class Userapi {
  static const String baseUrl = "https://grocex-api.onrender.com/api/v1/users/authenticate";

  Future<LoginResponse> login(UserModel request) async {
  try {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': request.email,
        'password': request.password
      }),
    );

    final responseData = json.decode(response.body);
    
    if (response.statusCode == 200) {
      if (responseData['data'] == null) {
        throw Exception("Missing data in response");
      }
      return LoginResponse.fromJson(responseData);
    } else {
      throw Exception(responseData['message'] ?? "Login failed");
    }
  } on FormatException {
    throw Exception("Invalid server response format");
  } catch (e) {
    throw Exception("Login failed: ${e.toString()}");
  }
}
}