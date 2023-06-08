import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:mangjek_app/app/bloc/tab_navigation/tab_navigation_cubit.dart';
import 'package:mangjek_app/app/firebase/firebase.dart';
import 'package:mangjek_app/app/networking/fcm_service.dart';
import 'package:mangjek_app/app/singleton/location_plugin.dart';
import 'package:mangjek_app/bootstrap/helpers.dart';
import 'package:mangjek_app/resources/pages/home/home_page_inner.dart';
import 'package:mangjek_app/resources/pages/menu/menu_page.dart';
import 'package:mangjek_app/resources/widgets/tab_navigation_widget.dart';
import 'package:mangjek_app/resources/pages/riwayat/riwayat_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';

import '../../../app/bloc/home/profile/profile_cubit.dart';

class HomePage extends NyStatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends NyState<HomePage> {
  late ProfileCubit _profileCubit;
  @override
  init() async {
    super.init();
    _profileCubit = context.read<ProfileCubit>()
      ..fetchCurrentProfileIfNotLoaded();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showDialogLocationRejected() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Aplikasi hanya dapat dijalankan dengan akses lokasi"),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  locationGranted = false;
                  if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  } else if (Platform.isIOS) {
                    exit(0);
                  }
                });
              },
              child: const Text("Close"),
            )
          ],
        );
      },
    );
  }

  bool locationGranted = true;
  bool notificationDenied = false;

  Future<void> tryToAccessLocation() async {
    Location locationPlugin = LocationPluginSingleton.getLocationPlugin();
    PermissionStatus statusPermission = await locationPlugin.hasPermission();
    if (statusPermission == PermissionStatus.denied ||
        statusPermission == PermissionStatus.deniedForever) {
      PermissionStatus statusPermission =
          await locationPlugin.requestPermission();

      if (statusPermission == PermissionStatus.denied ||
          statusPermission == PermissionStatus.deniedForever) {
        showDialogLocationRejected();
        return;
      }
    }

    bool isServiceEnabled = await locationPlugin.serviceEnabled();

    if (!isServiceEnabled) {
      isServiceEnabled = await locationPlugin.requestService();
    }

    if (!isServiceEnabled) {
      // not have access to location service
      showDialogLocationRejected();

      return;
    }

    locationGranted = true;
  }

  void tryToAccessNotification() async {
    NotificationSettings settings = await FcmInstance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      notificationDenied = true;
    }
  }

  void showDialogNotificationPermissionRejected(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title:
              Text("Aplikasi hanya dapat dijalankan dengan akses notifikasi"),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  } else if (Platform.isIOS) {
                    exit(0);
                  }
                });
              },
              child: const Text("Close"),
            )
          ],
        );
      },
    );
  }

  bool isInsertedFcmToken = false;

  void getFcmToken() async {
    if (isInsertedFcmToken) {
      return;
    }

    String? fcmToken = await FcmInstance.getToken();
    if (fcmToken == null) {
      return;
    }
    String token = await AuthInstance.currentUser?.getIdToken() ?? "";

    api<FcmService>((request) => request.insertFcmToken(
        uid: AuthInstance.currentUser!.uid, token: token, fcmToken: fcmToken));
  }

  final Map<int, Widget> mapPageNavigation = {
    0: HomePageInner(),
    1: HistoryPage(),
    2: MenuPage(),
  };

  @override
  Widget build(BuildContext context) {
    tryToAccessLocation();
    tryToAccessNotification();

    if (!locationGranted) {
      showDialogLocationRejected();
    }
    if (notificationDenied) {
      showDialogNotificationPermissionRejected(context);
    } else {
      getFcmToken();
      isInsertedFcmToken = true;
    }

    return BlocProvider(
      create: (context) => TabNavigationCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        bottomNavigationBar: TabNavigation(),
        body: SafeArea(
          child: BlocBuilder<TabNavigationCubit, TabNavigationState>(
            builder: (context, state) =>
                mapPageNavigation[state.activeIndex] ?? Container(),
          ),
        ),
      ),
    );
  }
}
