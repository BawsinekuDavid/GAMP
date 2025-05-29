// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:gmarket_app/models/user_model.dart'; // You'll need to create this model

// class UserProvider with ChangeNotifier {
//   User? _currentUser;
//   bool _isLoading = false;
//   String _error = '';
//   late Box<User> _userBox;

//   User? get currentUser => _currentUser;
//   bool get isLoading => _isLoading;
//   String get error => _error;
//   bool get isLoggedIn => _currentUser != null;

//   Future<void> initialize() async {
//     _userBox = await Hive.openBox<User>('userBox');
//     await _loadCurrentUser();
//   }

//   Future<void> _loadCurrentUser() async {
//     try {
//       _currentUser = _userBox.get('currentUser');
//       notifyListeners();
//     } catch (e) {
//       _error = 'Failed to load user data';
//       notifyListeners();
//     }
//   }

//   Future<void> login({
//     required String email,
//     required String password,
//   }) async {
//     _isLoading = true;
//     _error = '';
//     notifyListeners();

//     try {
//       // Here you would typically call your authentication API
//       // For now, we'll simulate a successful login
//       await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
      
//       final user = User(
//         id: 'user_${DateTime.now().millisecondsSinceEpoch}',
//         email: email,
//         name: 'User Name', // You'd get this from your API
//         phoneNumber: '',
//         addresses: [],
//       );

//       await _userBox.put('currentUser', user);
//       _currentUser = user;
//       _error = '';
//     } catch (e) {
//       _error = 'Login failed: ${e.toString()}';
//       rethrow;
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   Future<void> register({
//     required String email,
//     required String password,
//     required String name,
//     required String phoneNumber,
//   }) async {
//     _isLoading = true;
//     _error = '';
//     notifyListeners();

//     try {
//       // Simulate API call for registration
//       await Future.delayed(const Duration(seconds: 1));
      
//       final user = User(
//         id: 'user_${DateTime.now().millisecondsSinceEpoch}',
//         email: email,
//         name: name,
//         phoneNumber: phoneNumber,
//         addresses: [],
//       );

//       await _userBox.put('currentUser', user);
//       _currentUser = user;
//       _error = '';
//     } catch (e) {
//       _error = 'Registration failed: ${e.toString()}';
//       rethrow;
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   Future<void> logout() async {
//     try {
//       await _userBox.delete('currentUser');
//       _currentUser = null;
//       _error = '';
//       notifyListeners();
//     } catch (e) {
//       _error = 'Logout failed: ${e.toString()}';
//       rethrow;
//     }
//   }

//   Future<void> updateUserProfile(User updatedUser) async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       await _userBox.put('currentUser', updatedUser);
//       _currentUser = updatedUser;
//       _error = '';
//     } catch (e) {
//       _error = 'Profile update failed: ${e.toString()}';
//       rethrow;
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   void clearError() {
//     _error = '';
//     notifyListeners();
//   }
// }