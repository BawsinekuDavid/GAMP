import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as path;
import '../models/product_createRequest.dart';
import '../models/products_module.dart';
import '../models/category_module.dart';

class ProductService {
  static const String _baseUrl = 'https://grocex-api.onrender.com/api/v1/products';
    final Logger _logger = Logger();

  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      _logger.i("Fetched products successfully");
      _logger.d("Response body: ${response.body}");
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

  Future<Product> createProduct(ProductCreateRequest product) async {
    var uri = Uri.parse(_baseUrl);
    var request = http.MultipartRequest('POST', uri);
    request.headers['Content-Type'] = 'multipart/form-data';
    request.headers['Accept'] = 'application/json';

    

    request.fields['name'] = product.name;
    request.fields['quantity'] = product.quantity.toString();
    request.fields['price'] = product.price.toString();
    request.fields['categoryId'] = product.categoryId;
    request.fields['ownerId'] = product.ownerId;
    if (product.id != null) request.fields['id'] = product.id!;

    if (product.filePath != null) {
      var file = File(product.filePath!);
      var stream = http.ByteStream(file.openRead());
      var length = await file.length();
      var multipartFile = http.MultipartFile(
        'file',
        stream,
        length,
        filename: path.basename(file.path),
        contentType: MediaType('image', path.extension(file.path).substring(1)),
      );
      request.files.add(multipartFile);
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = json.decode(response.body);
      _logger.i("Product created successfully");
      return Product.fromJson(responseData['data'] ?? responseData);
    } else {
      final errorData = json.decode(response.body);
      _logger.e("Failed to create product: ${errorData['message']}");
      throw Exception(errorData['message'] ?? 'Failed to create product');
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
        _logger.i("Product updated successfully");
        return Product.fromJson(responseData['data'] ?? responseData);
      } else {
        final errorData = json.decode(response.body);
        _logger.e("Failed to update product: ${errorData['message']}");
        throw Exception(errorData['message'] ?? 'Failed to update product');
      }
    } catch (e) {
      _logger.e("Error updating product: ${e.toString()}");
      throw Exception('Failed to update product: ${e.toString()}');
    }
  }

  Future<void> deleteProduct(Product product) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/${product.id}'),
      headers: {'Accept': 'application/json'},
    );
    if (response.statusCode == 204) {
      return;
    } else {
      final errorData = json.decode(response.body);
      throw Exception(errorData['message'] ?? 'Failed to delete product');
    }
  }

  Future<Product> approveProduct(String id) async {
    final response = await http.patch(
      Uri.parse('$_baseUrl/$id/approve'),
      headers: {
        'Content-Type': 'multipart/form-data',
        'Accept': 'multipart/form-data',
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