import 'package:bvg_partner/modules/auth/forgot/forgot_password_screen.dart';
import 'package:bvg_partner/modules/auth/registration/registration_screen.dart';
import 'package:bvg_partner/routes/route_const.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../modules/auth/login/login_screen.dart';
import '../modules/launch/fetch_location.dart';
import '../modules/launch/splash_screen.dart';

class AppRouterConfig{
  static final GoRouter goRouter = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: "/splash",
    routes: [
      GoRoute(
        name: RouteConst.splashScreenRoute,
        path: '/splash',
        pageBuilder: (context, state) {
          return const MaterialPage(child: SplashScreen());
        },
      ),
      GoRoute(
        name: RouteConst.fetchLocationRoute,
        path: '/fetchLocation',
        pageBuilder: (context, state) {
          return const MaterialPage(child: FetchLocation());
        },
      ),
      GoRoute(
        name: RouteConst.loginScreenRoute,
        path: '/login',
        pageBuilder: (context, state) {
          return const MaterialPage(child: LoginScreen());
        },
      ),
      GoRoute(
        name: RouteConst.regScreenRoute,
        path: '/register',
        pageBuilder: (context, state) {
          return const MaterialPage(child: RegistrationScreen());
        },
      ),
      GoRoute(
        name: RouteConst.forgotPassScreenRoute,
        path: '/forgot',
        pageBuilder: (context, state) {
          return const MaterialPage(child: ForgotScreen());
        },
      ),
    ],
  );
}