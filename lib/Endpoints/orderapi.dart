import 'package:gmarket_app/models/order_module.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';

class OrderApi {
  final String _baseUrl = "https://grocex-api.onrender.com/api/v1/orders/users/7ddbeb1a-9b61-493a-8c29-f90eee1c4287";
  final Logger logger = Logger();

  Future<List<Order>> fetchOrdersByUser(   ) async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        logger.d("API Response: $decodedBody");

        if (decodedBody is List) {
          return decodedBody.map((json) => Order.fromJson(json)).toList();
        } else if (decodedBody is Map<String, dynamic>) {
          if (decodedBody['orders'] is List) {
            return (decodedBody['orders'] as List)
                .map((json) => Order.fromJson(json))
                .toList();
          } else if (decodedBody['data'] is List) {
            return (decodedBody['data'] as List)
                .map((json) => Order.fromJson(json))
                .toList();
          }
        }
        throw Exception("Unexpected response format");
      } else {
        throw Exception(
            "Failed to fetch orders");
      }
    } catch (e) {
      logger.e("Error fetching orders for user ", error: e);
      throw Exception("Failed to fetch orders: ${e.toString()}");
    }
  }

Future<Order> createOrderForUser(String userId, List<OrderItem> orderItem) async {
  try {
    final response = await http.post(
      Uri.parse(_baseUrl), // Adjust endpoint as needed
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode({
        'items': orderItem.map((item)=>item.toJson()).toList(),
        'userId': userId, // Include user ID in the request
      }),
    );

    if (response.statusCode == 201) {
      final responseData = json.decode(response.body);
      logger.i("Order created successfully for user $userId: ${responseData['id']}");
      return Order.fromJson(responseData);
    } else {
      logger.e(
          "Failed to create order for user $userId. Status: ${response.statusCode}, Body: ${response.body}");
      throw Exception(
          'Failed to create order. Status: ${response.statusCode}');
    }
  } catch (e) {
    logger.e("Error creating order for user $userId", error: e);
    throw Exception('Failed to create order: ${e.toString()}');
  }
}

  

  Future<Order> updateOrderStatus(String orderId, String newStatus) async {
    try {
      final response = await http.patch(
        Uri.parse('$_baseUrl/$orderId/status'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({'status': newStatus}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        logger.i("Order status updated: $orderId to $newStatus");
        return Order.fromJson(responseData);
      } else {
        logger.e(
            "Failed to update order status. Status: ${response.statusCode}, Body: ${response.body}");
        throw Exception(
            'Failed to update order status. Status: ${response.statusCode}');
      }
    } catch (e) {
      logger.e("Error updating order status", error: e);
      throw Exception('Failed to update order status: ${e.toString()}');
    }
  }

  Future<bool> deleteOrder(String orderId) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/$orderId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 204) {
        logger.i("Order deleted successfully: $orderId");
        return true;
      } else {
        logger.e(
            "Failed to delete order. Status: ${response.statusCode}, Body: ${response.body}");
        throw Exception(
            'Failed to delete order. Status: ${response.statusCode}');
      }
    } catch (e) {
      logger.e("Error deleting order", error: e);
      throw Exception('Failed to delete order: ${e.toString()}');
    }
  }

  Future<Order> getOrderById(String orderId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/$orderId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        logger.i("Retrieved order: $orderId");
        return Order.fromJson(responseData);
      } else {
        logger.e(
            "Failed to fetch order. Status: ${response.statusCode}, Body: ${response.body}");
        throw Exception(
            'Failed to fetch order. Status: ${response.statusCode}');
      }
    } catch (e) {
      logger.e("Error fetching order", error: e);
      throw Exception('Failed to fetch order: ${e.toString()}');
    }
  }
}