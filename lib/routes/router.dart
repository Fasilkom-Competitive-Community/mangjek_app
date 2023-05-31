import 'package:flutter/material.dart';
import 'package:mangjek_app/app/singleton/media_query.dart';
import 'package:mangjek_app/resources/pages/home/home_page.dart';
import 'package:mangjek_app/resources/pages/order_details/order_details_page.dart';
import 'package:mangjek_app/resources/pages/orders/choose_from_map/choose_from_map_page.dart';
import 'package:mangjek_app/resources/pages/orders/choose_location/choose_location.dart';
import 'package:mangjek_app/resources/pages/profile/profile_page.dart';
import 'package:mangjek_app/routes/constant.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:mangjek_app/resources/pages/orders/choose_location/widgets/order_inquiry_widget.dart';
import 'package:mangjek_app/app/bloc/order/order_cubit.dart';

import '../resources/pages/auth/login/login_widget.dart' as login;
import '../resources/pages/auth/onboarding/first_onboarding_widget.dart'
    as first_onboarding_widget;
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
      router.route(
        ROUTE_INITIAL_PAGE,
        (context) {
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
        },
        transition: PageTransitionType.fade,
      );

      router.route(
        ROUTE_HOME_PAGE,
        (context) => HomePage(),
      );

      router.route(
        ROUTE_PROFILE_PAGE,
        (context) => ProfileUserPage(),
      );

      // order routes
      router.route(
        ROUTE_ORDERS_CHOOSE_LOCATION,
        (context) => ChooseLocation(),
      );

      router.route(
        ROUTE_ORDERS_CHOOSE_FROM_MAP_PAGE,
        (context) => ChooseFromMapPage(),
      );

      router.route(
        ROUTE_ORDER_DETAILS_PAGE,
        (context) => OrderDetailPage(),
      );

      router.route(
        ROUTE_ORDER_INQUIRY_PAGE, 
        (context) => OrderInquiryWidget(orderCubit: OrderCubit(),),);
    });
