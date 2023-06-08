import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

import '../../app/networking/dio/base_api_service.dart';

/*
|--------------------------------------------------------------------------
| FcmService
| -------------------------------------------------------------------------
| Define your API endpoints

| Learn more https://nylo.dev/docs/4.x/networking
|--------------------------------------------------------------------------
*/

class FcmService extends BaseApiService {
  FcmService({BuildContext? buildContext}) : super(buildContext);

  Future<dynamic> insertFcmToken({
    required String uid,
    required String token,
    required String fcmToken,
    void Function(DioError)? handleFailure,
  }) async {
    return await network<dynamic>(
      request: (request) => request.put(
        "/users/${uid}/device-token",
        data: {
          "id": uid,
          "token": fcmToken,
        },
      ),
      bearerToken: token,
      handleFailure: handleFailure,
    );
  }
}
