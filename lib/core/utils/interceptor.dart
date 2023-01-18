import 'package:debugging/core/config/helpers/auth_strings.dart';
import 'package:debugging/core/config/helpers/logger.dart';
import 'package:dio/dio.dart';

class AppInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters["apiKey"] = AuthStrings.apiKey;
    options.sendTimeout = 30000;
    debugLog(options.baseUrl + options.path);
    debugLog(options.headers);
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode! >= 200) {
      debugLog("Yes completed");
    }
    return super.onResponse(response, handler);
  }
}
