import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/products_module.dart';
import '../models/category_module.dart';

class ProductService {
  static const String _baseUrl = 'https://grocex-api.onrender.com/api/v1/products';

  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse(_baseUrl));
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      
      if (responseData['data'] is List) {
        final List<dynamic> productList = responseData['data'];
        return productList.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      throw Exception('Failed to load products: ${response.statusCode}');
    }
  }

  Future<Product> createProduct(Product product) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
         
        body: json.encode({
          'product': product.product,
          'unitPrice': product.unitPrice,
          'category': product.category,
          'quantity': product.quantity,
          'rating': product.rating,
          'imageUrl': product.imageUrl,
        }),
      );

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        return Product.fromJson(responseData['data'] ?? responseData);
      } else {
        final errorData = json.decode(response.body);
        throw Exception(errorData['message'] ?? 'Failed to create product');
      }
    } catch (e) {
      throw Exception('Failed to create product: ${e.toString()}');
    }
  }

  Future<Product> updateProduct(Product product) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/${product.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'product': product.product,
          'unitPrice': product.unitPrice,
          'category': product.category,
          'quantity': product.quantity,
          'rating': product.rating,
          'imageUrl': product.imageUrl,
          'isApproved': product.isApproved,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return Product.fromJson(responseData['data'] ?? responseData);
      } else {
        final errorData = json.decode(response.body);
        throw Exception(errorData['message'] ?? 'Failed to update product');
      }
    } catch (e) {
      throw Exception('Failed to update product: ${e.toString()}');
    }
  }

  Future<void> deleteProduct(String id) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/$id'),
      headers: {'Accept': 'application/json'},
    );
    
    if (response.statusCode != 204) {
      final errorData = json.decode(response.body);
      throw Exception(errorData['message'] ?? 'Failed to delete product');
    }
  }

  Future<Product> approveProduct(String id) async {
    final response = await http.patch(
      Uri.parse('$_baseUrl/$id/approve'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return Product.fromJson(responseData['data'] ?? responseData);
    } else {
      final errorData = json.decode(response.body);
      throw Exception(errorData['message'] ?? 'Failed to approve product');
    }
  }

  Future<Category> getCategory(String id) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$id'),
      headers: {'Accept': 'application/json'},
    );
    
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return Category.fromJson(responseData['data'] ?? responseData);
    } else {
      final errorData = json.decode(response.body);
      throw Exception(errorData['message'] ?? 'Failed to get category');
    }
  }
}