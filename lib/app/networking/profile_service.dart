import 'package:firebase_auth/firebase_auth.dart';
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

  @override
  String get baseUrl => getEnv('API_BASE_URL');

  @override
  final interceptors = {
    if (getEnv('APP_DEBUG') == true) PrettyDioLogger: PrettyDioLogger()
  };

  Future<UserResponse?> fetchProfile(String uid, String token) async {
    return await network<UserResponse>(
      request: (request) => request.get("/users/${uid}"),
      bearerToken: token,
    );
  }
}
