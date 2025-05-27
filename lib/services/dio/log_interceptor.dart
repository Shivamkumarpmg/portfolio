import 'package:bvg_partner/utils/common/common_functions.dart';
import 'package:dio/dio.dart';

class LoggingInterceptor extends InterceptorsWrapper {
  int maxCharactersPerLine = 200;

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    CommonFunctions.printLog("--> ${options.method} ${options.path}");
    CommonFunctions.printLog("Headers: ${options.headers.toString()}");
    CommonFunctions.printLog("<-- END HTTP");

    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    CommonFunctions.printLog(
      "<-- ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.path}",
    );

    String responseAsString = response.data.toString();

    if (responseAsString.length > maxCharactersPerLine) {
      int iterations = (responseAsString.length / maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        CommonFunctions.printLog(
          responseAsString.substring(i * maxCharactersPerLine, endingIndex),
        );
      }
    } else {
      CommonFunctions.printLog(response.data);
    }

    CommonFunctions.printLog("<-- END HTTP");

    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    CommonFunctions.printLog(
      "ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}",
    );
    return super.onError(err, handler);
  }
}
