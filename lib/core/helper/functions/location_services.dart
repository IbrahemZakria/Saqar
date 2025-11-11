import 'dart:developer';
import 'package:location/location.dart';

class LocationServices {
  static final Location _location = Location();

  /// ✅ تهيئة الخدمة والتصاريح بالكامل

  /// ✅ التحقق من تفعيل خدمة الـ GPS
  static Future<void> checkRequestLocationServices() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        log("⚠️ خدمة الـ GPS غير مفعّلة");
        throw LocationServicesException();
      }
    }
  }

  /// ✅ التحقق من الصلاحيات
  static Future<void> checkRequestLocationPermission() async {
    PermissionStatus permissionGranted = await _location.hasPermission();

    if (permissionGranted == PermissionStatus.deniedForever) {
      log("⚠️ الصلاحية مرفوضة دائمًا، يجب تفعيلها من الإعدادات");
      throw LocationPermissionException();
    }

    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        log("⚠️ لم يتم منح صلاحية الوصول للموقع");
        throw LocationPermissionException();
      }
    }
  }

  /// 📍 الحصول على الموقع الحالي
  static Future<LocationData?> getCurrentLocation() async {
    try {
      await checkRequestLocationServices();
      await checkRequestLocationPermission();
      return await _location.getLocation();
    } catch (e) {
      log("❌ خطأ أثناء الحصول على الموقع: $e");
      return null;
    }
  }

  /// 🔁 متابعة التغييرات في الموقع
  static Stream<LocationData> onLocationChanged() {
    return _location.onLocationChanged;
  }
}

class LocationPermissionException implements Exception {}

class LocationServicesException implements Exception {}
