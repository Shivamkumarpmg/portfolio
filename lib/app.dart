import 'package:bvg_partner/modules/auth/forgot/forgot_provider.dart';
import 'package:bvg_partner/modules/auth/login/login_provider.dart';
import 'package:bvg_partner/routes/app_router.dart';
import 'package:bvg_partner/utils/theme/app_theme.dart';
import 'package:bvg_partner/utils/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'di_container.dart' as di;
import 'modules/launch/launch_provider.dart';

Future<Widget> initializeApp()async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.initDi();
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeProvider>(create: (context) => di.sl<ThemeProvider>()),
      ChangeNotifierProvider<LaunchProvider>(create: (context) => di.sl<LaunchProvider>()),
      ChangeNotifierProvider<LoginProvider>(create: (context) => di.sl<LoginProvider>()),
      ChangeNotifierProvider<ForgotProvider>(create: (context) => di.sl<ForgotProvider>()),
    ],
      child: MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,             // Transparent background
        statusBarIconBrightness: Brightness.dark,       // Black icons (Android)
        statusBarBrightness: Brightness.light,          // Black text (iOS)
      ),
    );
    return MaterialApp.router(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      title: 'BVG Partner',
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: Provider.of<ThemeProvider>(context).themeMode,
      routerConfig: AppRouterConfig.goRouter,
    );
  }
}
