import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangjek_app/app/bloc/home/map/map_cubit.dart';
import 'package:mangjek_app/app/bloc/home/select_location/select_location_cubit.dart';
import 'package:mangjek_app/resources/pages/home/widgets/map.dart' as home_map;

import 'package:mangjek_app/resources/pages/home/widgets/bottom_home_widget.dart';
import 'package:mangjek_app/resources/pages/home/widgets/top_select_location_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';

class HomePageInner extends StatefulWidget {
  const HomePageInner({super.key});

  @override
  State<HomePageInner> createState() => _HomePageInnerState();
}

class _HomePageInnerState extends NyState<HomePageInner> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          // background / map
          // buildMapBackground(),
          home_map.MapWidget(context.read<MapCubit>()),

          BlocBuilder<SelectLocationCubit, SelectLocationState>(
            builder: (context, state) {
              return Visibility(
                visible: state is SelectLocationFocused,
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    getImageAsset("choose_location.png"),
                    height: 45,
                    width: 45,
                    scale: 1.6,
                  ),
                ),
              );
            },
          ),

          // bar atas
          TopSelectLocation(),

          BottomHome(),
        ],
      ),
    );
  }
}
