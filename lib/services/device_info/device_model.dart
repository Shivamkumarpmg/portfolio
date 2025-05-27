import 'dart:core';

class DeviceModel {
  String? deviceType;        // Android or iOS
  String? deviceIp;          // e.g., 192.168.1.2
  String? deviceId;          // Unique ID from device
  String? model;             // e.g., SM-A515F
  String? deviceModel;       // e.g., a51
  String? osVersion;         // e.g., 13
  bool? isPhysicalDevice;
  String? manufacturer;     // Android only
  String? systemName;       // iOS only

  DeviceModel({
    this.deviceType,
    this.deviceIp,
    this.deviceId,
    this.model,
    this.deviceModel,
    this.osVersion,
    this.isPhysicalDevice,
    this.manufacturer,
    this.systemName,
  });

  @override
  String toString() {
    return 'DeviceModel(deviceType: $deviceType, deviceIp: $deviceIp, deviceId: $deviceId, '
        'model: $model, deviceModel: $deviceModel, osVersion: $osVersion, '
        'isPhysicalDevice: $isPhysicalDevice, manufacturer: $manufacturer, systemName: $systemName)';
  }
}