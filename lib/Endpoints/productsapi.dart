// products_api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../models/products_module.dart';

class ProductsApi {
  static const String baseUrl =
      "https://grocex-api.onrender.com/api/v1/products";
  final Logger _logger = Logger();

  Future<List<Product>> fetchProductsByCategory(String category) async {
    try {
      _logger.i("Fetching $category products");

      final response = await http.get(
        Uri.parse('$baseUrl?category=$category'),
      );

      _logger.d("Response status: ${response.statusCode}");
      _logger.d("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        // Handle different response formats
        if (responseData is List) {
          return responseData.map((json) => Product.fromJson(json)).toList();
        } else if (responseData['data'] is List) {
          return (responseData['data'] as List)
              .map((json) => Product.fromJson(json))
              .toList();
        } else {
          throw Exception("Invalid response format");
        }
      } else {
        throw Exception(
            "Failed to load $category products: ${response.statusCode}");
      }
    } on FormatException catch (e) {
      _logger.e("JSON parsing error: ${e.message}");
      throw Exception("Invalid product data format");
    } catch (e) {
      _logger.e("Product fetch error: ${e.toString()}");
      throw Exception("Failed to fetch $category products");
    }
  }

  Future<List<Product>> fetchAllProducts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        // Handle different API response formats
        if (responseData is List) {
          // Direct array response
          return responseData.map((json) => Product.fromJson(json)).toList();
        } else if (responseData['data'] is List) {
          // Response with data object containing array
          return (responseData['data'] as List)
              .map((json) => Product.fromJson(json))
              .toList();
        } else {
          throw Exception('Invalid API response format');
        }
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch products: ${e.toString()}');
    }
  }
}
