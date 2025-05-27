import 'constants.dart';

class AppConfig {
  String baseUrl = "";
  Flavor appFlavor = Flavor.development;

  static AppConfig shared = AppConfig._internal();

  factory AppConfig({
    String baseUrl = "",
    Flavor appFlavor = Flavor.development,
  }) {
    return shared = AppConfig._internal(baseUrl, appFlavor);
  }

  AppConfig._internal([this.baseUrl = "", this.appFlavor = Flavor.development]);

  static AppConfig get instance {
    return shared;
  }
}
