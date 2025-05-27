import 'package:bvg_partner/services/api_services/api_service.dart';
import 'package:flutter/cupertino.dart';


class ForgotProvider with ChangeNotifier {
  final ApiService apiService;
  ForgotProvider(this.apiService);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final List<TextEditingController> controllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());


  bool showPassword = true;
  void togglePasswordVisibility() {
    showPassword = !showPassword;
    notifyListeners();
  }

  void onOtpChanged(String value, int index) {
    if (value.length == 1 && index < 5) {
      focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
    if(index == 5){
      // if ((checkValidPassword())) {
      //   submitOtp();
      // }
    }
  }

  bool checkValid() {
    if (emailController.text.trim().isNotEmpty) {
      return true;
    }
    return false;
  }


  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
