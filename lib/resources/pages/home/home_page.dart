import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:mangjek_app/app/bloc/tab_navigation/tab_navigation_cubit.dart';
import 'package:mangjek_app/app/singleton/location_plugin.dart';
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
    _profileCubit = context.read<ProfileCubit>()..fetchCurrentProfile();
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

  final Map<int, Widget> mapPageNavigation = {
    0: HomePageInner(),
    1: HistoryPage(),
    2: MenuPage(),
  };

  @override
  Widget build(BuildContext context) {
    tryToAccessLocation();

    if (!locationGranted) {
      showDialogLocationRejected();
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
