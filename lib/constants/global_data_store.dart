import 'package:bvg_partner/services/location/location_model.dart';
import 'package:bvg_partner/services/device_info/device_model.dart';

import '../modules/auth/login/login_response.dart';

class GlobalDataStore{
  static DeviceModel? deviceInfo;
  static LocationModel? currentLocation;
  static UserDetails? userInfo;
}



