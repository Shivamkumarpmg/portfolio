import 'package:bvg_partner/constants/constants.dart';
import 'package:bvg_partner/constants/global_data_store.dart';
import 'package:bvg_partner/modules/auth/login/login_response.dart';
import 'package:bvg_partner/services/api_services/api_dynamic_response.dart';
import 'package:bvg_partner/services/api_services/api_service.dart';
import 'package:bvg_partner/services/location/location_model.dart';
import 'package:bvg_partner/utils/common/common_functions.dart';
import 'package:bvg_partner/services/device_info/device_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../services/user_services/user_repo.dart';

class LoginProvider with ChangeNotifier {
  final ApiService apiService;
  final UserRepo userRepo;

  LoginProvider({required this.apiService,required this.userRepo});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  DeviceModel? deviceInfo = GlobalDataStore.deviceInfo;
  LocationModel? locationInfo = GlobalDataStore.currentLocation;

  LoginResponse loginData = LoginResponse();

  bool showPassword = true;
  String validationError = '';

  bool stayLoggedIn = false;

  void toggleStayLoggedIn() {
    stayLoggedIn = !stayLoggedIn;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    showPassword = !showPassword;
    notifyListeners();
  }

  STATUSAPI loginStatus = STATUSAPI.initState;

  login() async {
    loginStatus = STATUSAPI.loading;

    notifyListeners();
    try {
      var loginJsonData = {
        "email": emailController.value.text.trim(),
        "password": passwordController.value.text.trim(),
        "device_type": deviceInfo?.deviceType ?? '',
        "device_ip": deviceInfo?.deviceIp ?? '',
        "device_id": deviceInfo?.deviceId ?? '',
        "device_model": deviceInfo?.deviceModel ?? '',
        "latitude": locationInfo?.longitude ?? '',
        "longitude": locationInfo?.latitude ?? "",
      };
      CommonFunctions.printLog("Login Request: $loginJsonData");
      ApisResponse apisResponse = await apiService.login(loginJsonData);
      loginData = LoginResponse.fromJson(apisResponse.response?.data);
      if (loginData.status == true) {
        GlobalDataStore.userInfo = loginData.data?.userDetails;
        userRepo.setToken(loginData.data?.token ?? '');
        userRepo.setPrefValue(loginData.toJson().toString());
        CommonFunctions.printLog("Token: ${userRepo.getToken()}");
        loginStatus = STATUSAPI.successState;
        notifyListeners();
      } else {
        loginStatus = STATUSAPI.errorState;
        notifyListeners();
        return;
      }
    } catch (e) {
      loginStatus = STATUSAPI.errorState;
      notifyListeners();
    }
  }

  checkValid() {
    if (emailController.text.isEmpty) {
      validationError = "Email is required";
      return false;
    } else if (!checkEmailValidation(emailController.text)) {
      validationError = "Not a valid email address";
      return false;
    } else if (passwordController.text.isEmpty) {
      validationError = "Password is required";
      return false;
    }
    validationError = '';
    return true;
  }

  bool checkEmailValidation(String email) {
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(pattern);
    validationError = 'Not a valid email address';
    notifyListeners();
    return regExp.hasMatch(email) && email.isNotEmpty;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
