import 'package:bvg_partner/constants/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepo{
  final SharedPreferences preferences;
  UserRepo({required this.preferences});

  String? getPrefValue() => preferences.getString(AppConstants.userDataKey);
  String? getToken() => preferences.getString(AppConstants.authTokenKey);

  Future<void> setPrefValue(String value) async{
    await preferences.setString(AppConstants.userDataKey, value);
  }

  Future<void> setToken(String value) async{
    await preferences.setString(AppConstants.authTokenKey, value);
  }

  Future<void> clearPref() async{
    await preferences.clear();
  }


}
