import 'package:dio/dio.dart';

class ApisResponse {
  late Response? response;
  final dynamic error;

  ApisResponse(this.response, this.error);

  ApisResponse.withError(dynamic errorValue)
      : response = null,
        error = errorValue;

  ApisResponse.withSuccess(Response responseValue)
      : response = responseValue,
        error = null;
}