import 'package:flutter/material.dart';
import 'package:mangjek_app/app/singleton/media_query.dart';
import 'package:mangjek_app/resources/pages/profile/profile_page.dart';
import 'package:mangjek_app/routes/constant.dart';
import 'package:nylo_framework/nylo_framework.dart';

import '../resources/pages/auth/onboarding/first_onboarding_widget.dart'
    as first_onboarding_widget;

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
        return first_onboarding_widget.OnBoarding();
      });
      router.route(ROUTE_PROFILE_PAGE, (context) => ProfileUserPage());
    });
