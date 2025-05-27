import 'dart:io';

import 'package:bvg_partner/constants/global_data_store.dart';
import 'package:bvg_partner/services/location/location_model.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:network_info_plus/network_info_plus.dart';

import '../../constants/constants.dart';
import '../../utils/common/common_functions.dart';
import '../../services/device_info/device_model.dart';

class LaunchProvider extends ChangeNotifier {

  //Location Service
  LocationModel currentLocation = LocationModel();
  String currentLocationString = "";
  LocationStatus locationStatus = LocationStatus.inital;
  Future<void> getCurrentAddress() async {
    try {
      locationStatus = LocationStatus.fetching;

      // Ensure location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception("Location services are disabled.");
      }

      // Request permission if not already granted
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception("Location permission denied.");
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception("Location permission permanently denied.");
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
            accuracy: LocationAccuracy.high
        ),
      );

      currentLocation = LocationModel(
        latitude: position.latitude.toString(),
        longitude: position.longitude.toString(),
      );

      GlobalDataStore.currentLocation = currentLocation;

      CommonFunctions.printLog(
        'Lat: ${position.latitude}, Long: ${position.longitude}',
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        currentLocationString =
        "${place.name}, ${place.subLocality},${place.locality}, ${place.administrativeArea}, ${place.country},${place.postalCode},";
        locationStatus = LocationStatus.success;
      } else {
        currentLocationString = "Location not found";
        locationStatus = LocationStatus.failed;
      }
    } catch (e) {
      locationStatus = LocationStatus.failed;
      currentLocationString = "Location not found";
      CommonFunctions.printLog("Location error: $e");
    }

    notifyListeners(); // Always notify at the end
  }

  //Device Info
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  static final NetworkInfo _networkInfo = NetworkInfo();
  Future<DeviceModel> getDeviceDetails() async {
    final deviceIp = await _networkInfo.getWifiIP() ?? 'Unknown';
    DeviceModel deviceModel = DeviceModel();
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfoPlugin.androidInfo;
      deviceModel = DeviceModel(
        deviceType: 'Android',
        deviceIp: deviceIp,
        deviceId: androidInfo.id,
        model: androidInfo.model,
        deviceModel: androidInfo.device,
        osVersion: androidInfo.version.release,
        isPhysicalDevice: androidInfo.isPhysicalDevice,
        manufacturer: androidInfo.manufacturer,
      );
      GlobalDataStore.deviceInfo = deviceModel;
      return deviceModel;
    } else if (Platform.isIOS) {
      final iosInfo = await _deviceInfoPlugin.iosInfo;
      deviceModel = DeviceModel(
        deviceType: 'iOS',
        deviceIp: deviceIp,
        deviceId: iosInfo.identifierForVendor ?? 'Unknown',
        model: iosInfo.utsname.machine,
        deviceModel: iosInfo.model,
        osVersion: iosInfo.systemVersion,
        isPhysicalDevice: iosInfo.isPhysicalDevice,
        systemName: iosInfo.systemName,
      );
      GlobalDataStore.deviceInfo = deviceModel;
      return deviceModel;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

}
