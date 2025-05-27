import 'package:bvg_partner/constants/app_config.dart';

class Apis {
  static const String user = "v1/user/";
  static final String baseUrl = "${AppConfig.instance.baseUrl}$user";

  //API Endpoints
  static final String login = "${baseUrl}login";
}
