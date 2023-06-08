import 'package:flutter/material.dart';
import 'package:mangjek_app/app/models/user.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../app/networking/dio/base_api_service.dart';
import 'package:nylo_framework/nylo_framework.dart';

/*
|--------------------------------------------------------------------------
| ProfileService
| -------------------------------------------------------------------------
| Define your API endpoints

| Learn more https://nylo.dev/docs/4.x/networking
|--------------------------------------------------------------------------
*/

class ProfileService extends BaseApiService {
  ProfileService({BuildContext? buildContext}) : super(buildContext);

  Future<UserResponse?> fetchProfile(
    String uid,
    String token, {
    void Function(DioError)? handleFailure,
  }) async {
    return await network<UserResponse>(
      request: (request) => request.get("/users/${uid}",
          options: Options(
            headers: {
              "Authorization": "Bearer ${token}",
            },
          )),
      handleFailure: handleFailure,
    );
  }

  Future<RegisterResponse?> registerProfile(
    String uid,
    String name,
    String email,
    String phoneNumber,
    String token,
    String fcmToken, {
    void Function(DioError)? handleFailure,
  }) async {
    return await network<RegisterResponse>(
      request: (request) => request.post("/users", data: {
        "id": uid,
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "token": fcmToken,
      }),
      bearerToken: token,
      handleFailure: handleFailure,
    );
  }
}
