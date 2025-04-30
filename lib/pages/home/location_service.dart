import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  /// Checks if location services are enabled and permissions are granted
  static Future<bool> get isLocationEnabled async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return false;
      
      final permission = await Geolocator.checkPermission();
      return permission == LocationPermission.always || 
             permission == LocationPermission.whileInUse;
    } catch (e) {
      return false;
    }
  }

  /// Gets current position with detailed error handling
  static Future<Position> getCurrentPosition({
    LocationAccuracy accuracy = LocationAccuracy.best,
    Duration timeout = const Duration(seconds: 10),
  }) async {
    try {
      // Check if location services are enabled
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw LocationServiceDisabledException();
      }

      // Check permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw LocationPermissionDeniedException();
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw LocationPermissionPermanentlyDeniedException();
      }

      // Get position with timeout
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: accuracy,
      ).timeout(timeout, onTimeout: () {
        throw LocationTimeoutException();
      });
    } on PlatformException catch (e) {
      throw LocationServiceException(e.message ?? 'Unknown platform error');
    }
  }

  /// Converts coordinates to human-readable address
  static Future<String> getAddressFromCoordinates({
    required double latitude,
    required double longitude,
    bool shortFormat = true,
  }) async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isEmpty) return 'Unknown Location';

      final place = placemarks.first;
      return shortFormat
          ? _formatShortAddress(place)
          : _formatLongAddress(place);
    } catch (e) {
      return 'Could not get address';
    }
  }

  static String _formatShortAddress(Placemark place) {
    return [
      if (place.locality?.isNotEmpty ?? false) place.locality,
      if (place.administrativeArea?.isNotEmpty ?? false) place.administrativeArea,
    ].where((part) => part != null).join(', ');
  }

  static String _formatLongAddress(Placemark place) {
    return [
      place.street,
      place.subLocality,
      place.locality,
      place.postalCode,
      place.administrativeArea,
      place.country
    ].where((part) => part?.isNotEmpty ?? false).join(', ');
  }
}

// Custom exceptions for better error handling
class LocationServiceDisabledException implements Exception {
  final String message = 'Location services are disabled';
}

class LocationPermissionDeniedException implements Exception {
  final String message = 'Location permissions are denied';
}

class LocationPermissionPermanentlyDeniedException implements Exception {
  final String message = 'Location permissions are permanently denied';
}

class LocationTimeoutException implements Exception {
  final String message = 'Location request timed out';
}

class LocationServiceException implements Exception {
  final String message;
  LocationServiceException(this.message);
}