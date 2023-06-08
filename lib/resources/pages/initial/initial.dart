import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mangjek_app/app/firebase/firebase.dart';
import 'package:mangjek_app/app/singleton/media_query.dart';
import 'package:mangjek_app/resources/pages/auth/onboarding/first_onboarding_widget.dart';
import 'package:mangjek_app/resources/pages/auth/onboarding/splash_screen_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';

class InitialPage extends NyStatefulWidget {
  InitialPage({Key? key}) : super(key: key);

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends NyState {
  bool showModalPermission = false;

  @override
  boot() async {
    super.boot();
  }

  @override
  Widget build(BuildContext context) {
    MediaQuerySingleton.init(MediaQuery.of(context).size);
    return Logo();
  }
}
