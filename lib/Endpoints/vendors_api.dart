import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../models/vendors_module.dart';

class VendorsApi {
  static const String _baseUrl = 'https://grocex-api.onrender.com/api/v1/vendors/vendors';
  final Logger _logger = Logger();
   

  Future<List<Vendor>> fetchAllVendors() async {
    try {
      _logger.i('Fetching vendors from $_baseUrl');
      
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      _logger.d('Response status: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        _logger.d('Response data: $responseData');
        
        List<dynamic> vendorsList = [];
        
        // Handle different response formats
        if (responseData is List) {
          vendorsList = responseData;
        } else if (responseData is Map) {
          if (responseData['data'] is List) {
            vendorsList = responseData['data'];
          } else if (responseData['vendors'] is List) {
            vendorsList = responseData['vendors'];
          } else if (responseData['items'] is List) {
            vendorsList = responseData['items'];
          } else {
            throw const FormatException('Invalid vendor list format in response');
          }
        } else {
          throw const FormatException('Unexpected response format');
        }

        return vendorsList.map((json) => Vendor.fromJson(json)).toList();
      } else {
        _logger.e('API Error: ${response.statusCode} - ${response.body}');
        throw HttpException('Failed to load vendors: ${response.statusCode}');
      }
    }  catch (e) {
      _logger.e('Unexpected error: ${e.toString()}');
      throw Exception('Failed to fetch vendors');
    }
  }
}