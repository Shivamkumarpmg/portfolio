import 'package:bvg_partner/app.dart';
import 'package:bvg_partner/constants/app_config.dart';
import 'package:bvg_partner/constants/constants.dart';
import 'package:flutter/cupertino.dart';

void main()async{
  AppConfig(
    baseUrl: '${AppConstants.developBaseUrl}/',
    appFlavor: Flavor.development
  );
  runApp(await initializeApp());
}