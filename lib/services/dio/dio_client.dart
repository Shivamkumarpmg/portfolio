import 'dart:io';
import 'package:bvg_partner/services/user_services/user_repo.dart';
import 'package:bvg_partner/utils/common/common_functions.dart';
import 'package:dio/dio.dart';

class DioClient {
  final String baseUrl;
  final LogInterceptor logInterceptor;
  final UserRepo _userRepo;

  String? token;
  late Dio dio;

  DioClient(
    this.baseUrl,
    Dio dioService, {
    required this.logInterceptor,
    required UserRepo userRepo,
  }) : _userRepo = userRepo {
    token = _userRepo.getToken();
    dio = dioService;
    dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = const Duration(milliseconds: 30000)
      ..options.receiveTimeout = const Duration(milliseconds: 30000)
      ..httpClientAdapter
      ..options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
    CommonFunctions.printLog("T: $token");
    dio.interceptors.add(logInterceptor);
  }

  Future<void> updateTokenInHeader() async {
    token = _userRepo.getToken();
    dio.options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> get(
    String api, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      updateTokenInHeader();
      var response = await dio.get(api, queryParameters: queryParameters);
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (e) {
      throw FormatException(e.toString());
    } on DioException {
      throw DioException(requestOptions: RequestOptions());
    } on Exception catch (e) {
      throw Exception(e.toString());
    } on Error {
      throw Error();
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(
    String api, {
    data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      updateTokenInHeader();
      var response = await dio.post(api, data: data, queryParameters: queryParameters);
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (e) {
      throw FormatException(e.toString());
    } on DioException {
      throw DioException(requestOptions: RequestOptions());
    } on Exception catch (e) {
      throw Exception(e.toString());
    } on Error {
      throw Error();
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> patch(
      String api, {
        data,
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      updateTokenInHeader();
      var response = await dio.patch(api, data: data, queryParameters: queryParameters);
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (e) {
      throw FormatException(e.toString());
    } on DioException {
      throw DioException(requestOptions: RequestOptions());
    } on Exception catch (e) {
      throw Exception(e.toString());
    } on Error {
      throw Error();
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(
      String api, {
        data,
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      updateTokenInHeader();
      var response = await dio.put(api, data: data, queryParameters: queryParameters);
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (e) {
      throw FormatException(e.toString());
    } on DioException {
      throw DioException(requestOptions: RequestOptions());
    } on Exception catch (e) {
      throw Exception(e.toString());
    } on Error {
      throw Error();
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(
      String api, {
        data,
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      updateTokenInHeader();
      var response = await dio.delete(api, data: data, queryParameters: queryParameters);
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (e) {
      throw FormatException(e.toString());
    } on DioException {
      throw DioException(requestOptions: RequestOptions());
    } on Exception catch (e) {
      throw Exception(e.toString());
    } on Error {
      throw Error();
    } catch (e) {
      rethrow;
    }
  }

}
