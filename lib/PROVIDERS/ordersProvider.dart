import 'package:flutter/material.dart';
import 'package:gmarket_app/models/order_module.dart';
import 'package:hive/hive.dart';
import '../Endpoints/orderapi.dart';

class OrdersProvider with ChangeNotifier {
  late final Box<Order> _ordersBox;
  List<Order> _orders = [];
  bool _isLoading = false;
  String _error = '';
  bool _isInitialized = false;
  bool _hasMore = true;
  int _currentPage = 1;
  final int _perPage = 10;
  String _currentUserId ="7ddbeb1a-9b61-493a-8c29-f90eee1c4287";

  List<Order> get orders => [..._orders];
  bool get isLoading => _isLoading;
  String get error => _error;
  bool get hasError => _error.isNotEmpty;
  bool get hasMore => _hasMore;
  bool get isInitialized => _isInitialized;

 OrdersProvider() {
    initialize();
  }
  Future<void> initialize({String? userId}) async {
    if (!_isInitialized) {
      try {
        _currentUserId = '7ddbeb1a-9b61-493a-8c29-f90eee1c4287';
        _ordersBox = await Hive.openBox<Order>('ordersBox_${userId ?? 'global'}');
        await loadLocalOrders();
        _isInitialized = true;
        notifyListeners();
      } catch (e) {
        _error = 'Failed to initialize orders: ${e.toString()}';
        notifyListeners();
      }
    }
  }

  Future<void> setUserId(String userId) async {
    if (_currentUserId != userId) {
      _currentUserId = userId;
      await _ordersBox.close();
      await initialize(userId: userId);
    }
  }

  Future<void> loadLocalOrders() async {
    try {
      _orders = _ordersBox.values.toList();
      _orders.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      notifyListeners();
    } catch (e) {
      _error = 'Failed to load local orders: ${e.toString()}';
      notifyListeners();
    }
  }

  Future<void> fetchAndSetOrders({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      _hasMore = true;
    } else if (!_hasMore || _isLoading) {
      return;
    }

    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final List<Order> fetchedOrders = await OrderApi().fetchOrdersByUser();

      if (refresh) {
        await _ordersBox.clear();
        _orders.clear();
      }

      for (final order in fetchedOrders) {
        await _ordersBox.put(order.id, order);
      }

      _orders.addAll(fetchedOrders);
      _orders.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      
      _hasMore = fetchedOrders.length == _perPage;
      _currentPage++;
      _error = '';
    } catch (e) {
      _error = 'Failed to fetch orders: ${e.toString()}';
      if (_orders.isEmpty) {
        await loadLocalOrders();
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

 


  Future<void> addOrder(OrderItem orderItem) async {
  _isLoading = true;
  notifyListeners();

  try {
    // Create order through API
    final createdOrder = await OrderApi().createOrderForUser(_currentUserId, [orderItem]);
    
    // Save to local storage
    await _ordersBox.put(createdOrder.id, createdOrder);
    
    // Add to local list
    _orders.insert(0, createdOrder);
    _error = '';
  } catch (e) {
    _error = 'Failed to place order: ${e.toString()}';
    // Consider adding a fallback mechanism here if needed
    rethrow;
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}

  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    isInitialized;
    _isLoading = true;
    notifyListeners();

    try {
      final updatedOrder = await OrderApi().updateOrderStatus(orderId, newStatus);
      await _ordersBox.put(_generateOrderKey(updatedOrder), updatedOrder);
      
      final index = _orders.indexWhere((o) => o.id == orderId);
      if (index >= 0) {
        _orders[index] = updatedOrder;
      }
      _error = '';
    } catch (e) {
      _error = 'Failed to update order status: ${e.toString()}';
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteOrder(String orderId) async {
    isInitialized;
    _isLoading = true;
    notifyListeners();

    try {
      await OrderApi().deleteOrder(orderId);
      await _ordersBox.delete(orderId);
      _orders.removeWhere((o) => o.id == orderId);
      _error = '';
    } catch (e) {
      _error = 'Failed to delete order: ${e.toString()}';
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Order?> getOrderById(String orderId) async {
    isInitialized;
    
    try {
      // Check local storage first
      final localOrder = _ordersBox.get(orderId);
      if (localOrder != null) return localOrder;
      
      // Fetch from API if not found locally
      final fetchedOrder = await OrderApi().getOrderById(orderId);
      await _ordersBox.put(_generateOrderKey(fetchedOrder), fetchedOrder);
      
      final index = _orders.indexWhere((o) => o.id == orderId);
      if (index >= 0) {
        _orders[index] = fetchedOrder;
      } else {
        _orders.add(fetchedOrder);
      }
          return fetchedOrder;
    } catch (e) {
      _error = 'Failed to fetch order details: ${e.toString()}';
      notifyListeners();
      return null;
    }
  }

  void clearError() {
    _error = '';
    notifyListeners();
  }

  Future<void> clearAllOrders() async {
    isInitialized;
    _isLoading = true;
    notifyListeners();

    try {
      await _ordersBox.clear();
      _orders.clear();
      _currentPage = 1;
      _hasMore = true;
      _error = '';
    } catch (e) {
      _error = 'Failed to clear orders: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String _generateOrderKey(Order order) {
    return order.product;
  }
}