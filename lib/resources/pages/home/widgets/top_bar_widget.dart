import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangjek_app/app/constants/choose_location.dart';
import 'package:mangjek_app/resources/pages/orders/choose_location/choose_location.dart';
import 'package:mangjek_app/routes/constant.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:mangjek_app/resources/widgets/input_location_widget.dart';
import 'package:mangjek_app/app/networking/profile_service.dart';
import 'package:mangjek_app/app/bloc/home/profile/profile_cubit.dart';

class TopBarHomeWidget extends StatefulWidget {
  const TopBarHomeWidget({super.key});

  @override
  State<TopBarHomeWidget> createState() => _TopBarHomeWidgetState();
}

class _TopBarHomeWidgetState extends State<TopBarHomeWidget> {
  late ProfileCubit _profileCubit;

  Widget buildTopBar() {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              height: 140,
              decoration: BoxDecoration(
                color: Color(0xFFF3C703),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Stack(
                children: [
                  _buildTopProfileBar(),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 70.0,
          child: Container(
            child: InputLocationWidget(
              context: context,
              onChangeJemput: (val) => {},
              onChangeTujuan: (val) => {},
              onTapJemput: onTapInputLocation(ChooseLocationType.TitikJemput),
              onTapTujuan: onTapInputLocation(ChooseLocationType.TitikTujuan),
            ),
          ),
        )
      ],
    );
  }

  void Function() onTapInputLocation(ChooseLocationType locationType) {
    return () {
      routeTo(
        ROUTE_ORDERS_CHOOSE_LOCATION,
        pageTransition: PageTransitionType.fade,
        data: locationType,
      );
    };
  }

  Widget _buildTopProfileBar() {
    return Wrap(
      children: [
        Container(
          // height: 100.0,
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 20,
            left: 20,
            right: 20,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFFF3C703),
          ),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoaded) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(),
                      child: Row(
                        children: [
                          Image.asset(getImageAsset("profile.png")),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(5.0, 0, 10.0, 0),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.user.name,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16.0),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 2.0)),
                              Text(
                                "Fasilkom",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10.0),
                              ),
                            ],
                          ),
                          Expanded(child: Container()),
                          Image.asset(
                            getImageAsset("logo-2.png"),
                            scale: 3.0,
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   height: 50,
                    // )
                  ],
                );
              } else {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(),
                      child: Row(
                        children: [
                          Image.asset(getImageAsset("profile.png")),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(5.0, 0, 10.0, 0),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "User",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16.0),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 2.0)),
                              Text(
                                "Fasilkom",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10.0),
                              ),
                            ],
                          ),
                          Expanded(child: Container()),
                          Image.asset(
                            getImageAsset("logo-2.png"),
                            scale: 3.0,
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   height: 50,
                    // )
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: SafeArea(
        child: Stack(
          children: [
            buildTopBar(),
          ],
        ),
      ),
    );
  }
}
