import 'dart:async';
import 'dart:convert';
import 'package:gmarket_app/models/category_module.dart';
import 'package:http/http.dart';

class Categoryapi {
  final String _baseUrl = "https://grocex-api.onrender.com/api/v1/categories";

  Future<List<Category>> fetchCategory() async {
    try {
      final response = await get(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        
        // Debug print to see the actual response structure
        print('API Response: $responseData');

        List<dynamic> categoryList = [];

        // Handle different response formats
        if (responseData is List) {
          categoryList = responseData;
        } else if (responseData is Map) {
          if (responseData.containsKey('data') && responseData['data'] is List) {
            categoryList = responseData['data'];
          } else if (responseData.containsKey('categories') && responseData['categories'] is List) {
            categoryList = responseData['categories'];
          } else if (responseData.containsKey('items') && responseData['items'] is List) {
            categoryList = responseData['items'];
          } else {
            throw Exception('Unexpected response format: ${responseData.keys}');
          }
        } else {
          throw Exception('Response is neither List nor Map');
        }

        // Parse categories with null safety
        return categoryList.map<Category>((item) {
          try {
            return Category.fromJson(item);
          } catch (e) {
            print('Error parsing category item: $item');
            throw Exception('Failed to parse category: ${e.toString()}');
          }
        }).toList();
      } else {
        throw Exception('Failed to load categories. Status: ${response.statusCode}');
      }
    } on TimeoutException {
      throw Exception('Request timed out');
    } on FormatException {
      throw Exception('Invalid response format');
    } catch (e) {
      throw Exception('Failed to fetch categories: ${e.toString()}');
    }
  }
}