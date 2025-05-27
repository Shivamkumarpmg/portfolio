import 'package:bvg_partner/modules/auth/forgot/forgot_provider.dart';
import 'package:bvg_partner/modules/auth/login/login_provider.dart';
import 'package:bvg_partner/services/api_services/api_service.dart';
import 'package:bvg_partner/services/dio/dio_client.dart';
import 'package:bvg_partner/services/enc_dec/aes.dart';
import 'package:bvg_partner/services/user_services/user_repo.dart';
import 'package:bvg_partner/utils/theme/theme_provider.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/api_constants.dart';
import 'modules/launch/launch_provider.dart';

final sl = GetIt.instance;

Future<void> initDi() async{
  sl.registerLazySingleton(() => DioClient(Apis.baseUrl, sl(), userRepo: sl(), logInterceptor: sl()));
  sl.registerLazySingleton(() => Dio());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Aes());
  sl.registerLazySingleton(() => LogInterceptor());
  sl.registerLazySingleton<UserRepo>(() => UserRepo(preferences: sl()));
  sl.registerLazySingleton<ThemeProvider>(() => ThemeProvider());
  sl.registerLazySingleton<LoginProvider>(() => LoginProvider(apiService: ApiService(dioClient: sl(), aes: sl()),userRepo: UserRepo(preferences: sl())));
  sl.registerLazySingleton<ForgotProvider>(()=> ForgotProvider(ApiService(dioClient: sl(), aes: sl())));
  sl.registerLazySingleton<LaunchProvider>(() => LaunchProvider());


}