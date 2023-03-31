import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangjek_app/app/bloc/home/profile/profile_cubit.dart';
import 'package:mangjek_app/app/models/user.dart' as user_model;

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends NyState<ProfileTab> {
  final User? user = FirebaseAuth.instance.currentUser;
  user_model.User? currentLoggedInUser;
  late ProfileCubit _profileCubit;

  @override
  init() async {
    super.init();
    _profileCubit = context.read<ProfileCubit>()..fetchCurrentProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 3,
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage:
                        AssetImage(getImageAsset('image-profile.png')),
                    maxRadius: 25,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 4, 2, 0),
                    child: BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, state) {
                      log("test here state : ${state}");
                      if (state is ProfileLoaded) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.user.name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "Fasilkom",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 10.0),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nama User",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "Fakultas User",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 10.0),
                            ),
                          ],
                        );
                      }
                    }),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: Image.asset(getImageAsset('edit.png')),
                  margin: EdgeInsets.fromLTRB(0, 12, 0, 10.5),
                )
              ],
            )),
          )
        ],
      ),
    );
  }
}
