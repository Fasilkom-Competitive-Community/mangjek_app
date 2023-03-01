import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../app/extensions/constructor.dart' as cons;
import '../../home/home_page.dart' as home_page;

class Logo extends StatefulWidget {
  const Logo({super.key, required this.data});
  final User? data;

  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> with TickerProviderStateMixin {
  splashScreen() async {
    var duration = const Duration(seconds: 4);
    return Timer(duration, () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          cons.FadePageTransition(
            tujuan: home_page.HomePage(),
            // data: widget.data,
          ),
        );
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
    splashScreen();
    super.initState();
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
