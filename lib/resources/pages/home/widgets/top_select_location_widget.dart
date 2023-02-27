import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangjek_app/app/bloc/home/map/map_cubit.dart';
import 'package:mangjek_app/app/bloc/home/select_location/select_location_cubit.dart';
import 'package:nylo_framework/nylo_framework.dart';

class TopSelectLocation extends StatefulWidget {
  const TopSelectLocation({super.key});

  @override
  State<TopSelectLocation> createState() => _TopSelectLocationState();
}

class _TopSelectLocationState extends NyState<TopSelectLocation> {
  FocusNode focusNodeTitikJemput = FocusNode();
  FocusNode focusNodeLokasiTujuan = FocusNode();

  late SelectLocationCubit selectLocationCubit;

  @override
  init() async {
    super.init();
    selectLocationCubit = context.read<SelectLocationCubit>();

    initFocusNodeListener();
  }

  void initFocusNodeListener() {
    focusNodeLokasiTujuan.addListener(() {
      selectLocationCubit.focusSelectLocation(
          focusNodeTitikJemput, focusNodeLokasiTujuan);
    });

    focusNodeTitikJemput.addListener(() {
      selectLocationCubit.focusSelectLocation(
          focusNodeTitikJemput, focusNodeLokasiTujuan);
    });
  }

  @override
  void dispose() {
    focusNodeLokasiTujuan.dispose();
    focusNodeTitikJemput.dispose();
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
                        focusNode: focusNodeTitikJemput,
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
                        focusNode: focusNodeLokasiTujuan,
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
                            ),
                            fillColor: Colors.white70),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
