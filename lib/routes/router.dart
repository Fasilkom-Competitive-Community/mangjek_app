import 'package:flutter/material.dart';
import 'package:mangjek_app/app/singleton/media_query.dart';
import 'package:mangjek_app/resources/pages/profile/profile_page.dart';
import 'package:mangjek_app/routes/constant.dart';
import 'package:nylo_framework/nylo_framework.dart';

import '../resources/pages/auth/onboarding/first_onboarding_widget.dart'
    as first_onboarding_widget;
import '../resources/pages/auth/login/login_widget.dart' as login;
import '../resources/pages/auth/onboarding/splash_screen_widget.dart' as logo;

/*
|--------------------------------------------------------------------------
| App Router
|
| * [Tip] Create pages faster 🚀
| Run the below in the terminal to create new a page.
| "flutter pub run nylo_framework:main make:page my_page"
| Learn more https://nylo.dev/docs/4.x/router
|--------------------------------------------------------------------------
*/

appRouter() => nyRoutes((router) {
      router.route(ROUTE_INITIAL_PAGE, (context) {
        MediaQuerySingleton.init(MediaQuery.of(context).size);
        return StreamBuilder(
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const first_onboarding_widget.OnBoarding();
            } else {
              return logo.Logo(data: snapshot.data);
            }
          },
          stream: login.firebaseUserStream,
        );
      });
      router.route(ROUTE_PROFILE_PAGE, (context) => ProfileUserPage());
    });
