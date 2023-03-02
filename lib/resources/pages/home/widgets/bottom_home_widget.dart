import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangjek_app/app/bloc/home/map/map_cubit.dart';
import 'package:mangjek_app/app/bloc/home/map_camera/map_camera_cubit.dart';
import 'package:mangjek_app/app/bloc/home/select_location/select_location_cubit.dart';
import 'package:mangjek_app/app/singleton/media_query.dart';
import 'package:mangjek_app/resources/pages/home/widgets/bottom_pesan_widget.dart';
import 'package:mangjek_app/resources/widgets/tab_navigation_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';

class BottomHome extends StatefulWidget {
  BottomHome({super.key});

  @override
  State<BottomHome> createState() => _BottomHomeState();
}

class _BottomHomeState extends NyState<BottomHome> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectLocationCubit, SelectLocationState>(
      builder: (context, state) {
        if (state is SelectLocationNotFocused) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: BottomPesan(paddingBottom: 20),
          );
        }

        return const SizedBox();
      },
    );
  }
}
