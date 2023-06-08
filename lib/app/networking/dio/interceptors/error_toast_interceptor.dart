import 'dart:developer';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nylo_framework/nylo_framework.dart';

class ErrorToastInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if ((err.response?.statusCode ?? 0) >= 400) {
      EasyLoading.showError(err.response!.data.toString(),
          duration: Duration(seconds: 2));
    }
    handler.next(err);
  }
}
