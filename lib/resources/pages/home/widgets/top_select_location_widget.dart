import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangjek_app/app/bloc/home/map/map_cubit.dart';
import 'package:mangjek_app/app/bloc/home/select_location/select_location_cubit.dart';
import 'package:mangjek_app/routes/constant.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:sizer/sizer.dart';

class TopSelectLocation extends NyStatefulWidget {
  TopSelectLocation({super.key});

  @override
  State<TopSelectLocation> createState() => _TopSelectLocationState();
}

class _TopSelectLocationState extends NyState<TopSelectLocation> {
  late SelectLocationCubit selectLocationCubit;

  final lokasiSuggestions = {
    0: "Fasilkom, Indralaya",
    1: "FKIP, Indralaya",
  };

  @override
  init() async {
    super.init();
    selectLocationCubit = context.read<SelectLocationCubit>();
    initFocusNodeListener();
  }

  Widget buildWidgetChooseLocationFromMap(SelectLocationFocused state) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 0),
          ],
          borderRadius: BorderRadius.all(Radius.circular(14))),
      child: Column(
        children: [
          // SizedBox(),
          // lokasi saat ini, pilih dari maps
          Container(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black87),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                      decoration: BoxDecoration(),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            getImageAsset("choose_location.png"),
                            width: 6.w,
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          Text("Lokasi saat ini")
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    selectLocationCubit.setLastIndexFocused(
                      state.titikJemputFocus ? 0 : 1,
                    );
                    routeTo(
                      ROUTE_ORDERS_CHOOSE_FROM_MAP_PAGE,
                      data: state.titikJemputFocus,
                      onPop: (_) {
                        if (selectLocationCubit.lastIndexFocused == 0) {
                          selectLocationCubit.focusNodeTitikJemput.unfocus();
                          selectLocationCubit.focusNodeLokasiTujuan
                              .requestFocus();
                        } else {
                          WidgetsBinding.instance.focusManager.primaryFocus
                              ?.unfocus();
                        }
                      },
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black87),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                      decoration: BoxDecoration(),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            getImageAsset("maps.png"),
                            width: 6.w,
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          Text("Pilih dari Maps")
                        ],
                      ),
                    ),
                  ),
                )),
                // Text("data")
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            height: 145,
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                const border = BorderSide(
                  color: Color(0xFFD4D8D6),
                );
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      print("tapped");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: (index == 0) ? border : BorderSide.none,
                          bottom: border,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      child: Text(lokasiSuggestions[index] ?? ""),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void initFocusNodeListener() {
    selectLocationCubit.focusNodeLokasiTujuan.addListener(() {
      selectLocationCubit.focusSelectLocation();
    });

    selectLocationCubit.focusNodeTitikJemput.addListener(() {
      selectLocationCubit.focusSelectLocation();
    });
  }

  @override
  void dispose() {
    selectLocationCubit.focusNodeLokasiTujuan.dispose();
    selectLocationCubit.focusNodeTitikJemput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Wrap(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 20,
              left: 20,
              right: 20,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 5.0,
                  color: Colors.black12,
                )
              ],
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
              ),
            ),
            child: BlocBuilder<MapCubit, MapState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          // horizontal: 10,
                          ),
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
                                "Gandi Subara",
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
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      // padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                      child: TextField(
                        enabled: state is MapReady,
                        focusNode: selectLocationCubit.focusNodeTitikJemput,
                        onChanged: (value) => {},
                        // style: TextStyle(color: Colors.pinkAccent, height:
                        //     MediaQuery.of(context).size.height/80),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          hintText: "Titik Jemput",
                          prefixIcon: Image.asset(
                            getImageAsset("titikJemput.png"),
                            scale: 3,
                          ),
                          fillColor: Colors.white70,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      // padding: const EdgeInsets.fromLTRB(20, 0, 20, 25),
                      child: TextField(
                        enabled: state is MapReady,
                        focusNode: selectLocationCubit.focusNodeLokasiTujuan,
                        onChanged: (value) => {},
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[600]),
                            hintText: "Lokasi Tujuan",
                            prefixIcon: Image.asset(
                              getImageAsset("tujuan.png"),
                              scale: 3,
                            ),
                            fillColor: Colors.white70),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          BlocBuilder<SelectLocationCubit, SelectLocationState>(
            builder: (context, state) {
              if (state is SelectLocationFocused) {
                return Container(
                  margin: EdgeInsets.only(
                    top: 1.h,
                  ),
                  child: buildWidgetChooseLocationFromMap(state),
                );
              }

              return const SizedBox();
            },
          )
        ],
      ),
    );
  }
}
