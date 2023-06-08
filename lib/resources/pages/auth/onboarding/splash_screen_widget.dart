import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangjek_app/app/bloc/home/profile/profile_cubit.dart';
import 'package:mangjek_app/app/extensions/constructor.dart' as cons;
import 'package:mangjek_app/app/firebase/firebase.dart';
import 'package:mangjek_app/routes/constant.dart';
import 'package:nylo_framework/nylo_framework.dart';

class Logo extends NyStatefulWidget {
  final User? user;
  Logo({super.key, this.user});

  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends NyState<Logo> with TickerProviderStateMixin {
  bool navigateToProfileFirst = false;

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
    super.initState();
  }

  late ProfileCubit _profileCubit;

  @override
  init() {
    super.init();
    _profileCubit = context.read<ProfileCubit>()
      ..fetchCurrentProfileIfNotLoaded();
  }

  void conditionalNavigates(ProfileState state) {
    if (state is ProfileNotFound) {
      // redirect after x seconds
      Timer(Duration(seconds: 3), () {
        routeTo(ROUTE_PROFILE_PAGE, data: {
          "from_onboarding": true,
        });
      });
      return;
    }

    if (state is ProfileFirebaseNotLoggedIn) {
      Timer(Duration(seconds: 3), () {
        routeTo(ROUTE_LOGIN_PAGE, data: {
          "from_onboarding": true,
        });
      });
      return;
    }

    if (state is ProfileLoadError) {
      log("Profile load error", error: state.error);
      Timer(Duration(seconds: 3), () {
        routeTo(ROUTE_ONBOARDING_PAGE);
      });
      return;
    }

    if (state is ProfileLoaded) {
      Timer(Duration(seconds: 3), () {
        routeTo(ROUTE_HOME_PAGE);
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: StreamBuilder<User?>(
              stream: firebaseUserStream,
              builder: (context, snapshot) {
                if ((snapshot.connectionState == ConnectionState.done ||
                        snapshot.connectionState == ConnectionState.active) &&
                    (!snapshot.hasData || snapshot.data == null)) {
                  _profileCubit.firebaseIsNotLoggedIn();
                }

                return BlocListener<ProfileCubit, ProfileState>(
                  listener: (context, state) {
                    conditionalNavigates(state);
                  },
                  listenWhen: (prev, curr) => prev is ProfileInitial,
                  child: FadeTransition(
                    opacity: _animation,
                    child: Image.asset(
                      cons.assetsImgLogoSikuning,
                      width: 150,
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
