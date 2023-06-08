import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mangjek_app/app/singleton/init.dart';
import 'package:mangjek_app/firebase_options.dart';
import 'package:nylo_framework/nylo_framework.dart';

import '/bootstrap/app.dart';
import 'bootstrap/boot.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Nylo nylo = await Nylo.init(setup: Boot.nylo, setupFinished: Boot.finished);
  await initSingleton();

  runApp(
    AppBuild(
      navigatorKey: NyNavigator.instance.router.navigatorKey,
      onGenerateRoute: nylo.router!.generator(),
      debugShowCheckedModeBanner: false,
      initialRoute: nylo.initialRoute,
      builder: EasyLoading.init(),
    ),
  );
}
