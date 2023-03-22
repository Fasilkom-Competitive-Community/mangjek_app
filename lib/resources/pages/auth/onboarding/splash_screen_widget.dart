import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mangjek_app/app/networking/profile_service.dart';
import 'package:mangjek_app/routes/constant.dart';
import 'package:mangjek_app/bootstrap/helpers.dart';

import '../../../../app/extensions/constructor.dart' as cons;

class Logo extends StatefulWidget {
  const Logo({super.key, required this.data});
  final User? data;

  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> with TickerProviderStateMixin {
  bool router = true;
  String validasi = "";

  splashScreen() async {
    var duration = const Duration(seconds: 4);
    return Timer(duration, () {
      if (mounted) {
        if (router == true) {
          Navigator.pushReplacementNamed(
            context,
            ROUTE_HOME_PAGE,
          );
        } else {
          Navigator.pushReplacementNamed(
            context,
            ROUTE_PROFILE_PAGE,
          );
        }
      }
    });
  }

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  )..repeat(reverse: true);

  late final Animation<double> _animation =
      CurvedAnimation(parent: _controller, curve: Curves.easeIn);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _getReq();
    splashScreen();
    super.initState();
  }

  Future _getReq() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    String uid = _auth.currentUser!.uid.toString();
    String? token = await _auth.currentUser!.getIdToken();
    
    final response = await api<ProfileService>((req) => req.fetchProfile(uid, token));
    var responseData = jsonDecode(response.body);
    setState(() {
      validasi = response.statusCode.toString();
    });
    _startPage(validasi);
    return responseData;
  }

  void _startPage(String validasi) {
    if (validasi == "404") {
      setState(() {
        router = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FadeTransition(
            opacity: _animation,
            child: Image.asset(
              cons.assetsImgLogoSikuning,
              width: 150,
            ),
          ),
        ),
      ),
    );
  }
}
