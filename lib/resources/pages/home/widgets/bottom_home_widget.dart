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
  late MapCubit _mapCubit;
  late SelectLocationCubit _selectLocationCubit;

  @override
  Widget build(BuildContext context) {
    _mapCubit = context.read<MapCubit>();
    _selectLocationCubit = context.read<SelectLocationCubit>();

    return BlocBuilder<SelectLocationCubit, SelectLocationState>(
      builder: (context, state) {
        if (state is SelectLocationNotFocused) {
          return Stack(
            children: [
              // pesan
              Align(
                alignment: Alignment.bottomCenter,
                child: BottomPesan(paddingBottom: 90),
              ),
              // bottom navigation bar
              Align(
                alignment: Alignment.bottomCenter,
                child: TabNavigation(),
              ),
            ],
          );
        }

        return showChooseLocationBottomWidget(
            context, state as SelectLocationFocused);
      },
    );
  }

  String getNamedSelectedLocation() {
    return "Fasilkom, Indralaya";
  }

  Widget showChooseLocationBottomWidget(
      BuildContext context, SelectLocationFocused stateSelectLocation) {
    String location =
        stateSelectLocation.titikJemputFocus ? "Lokasi Jemput" : "Lokasi Tujuan";

    return BlocBuilder<MapCameraCubit, MapCameraState>(
      builder: (context, state) {
        return Visibility(
          visible: state is MapCameraStop,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Wrap(
              children: [
                Column(
                  children: [
                    // icon to move to current location
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Image.asset(),
                        ],
                      ),
                    ),

                    // widget to click lanjutkan
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ).copyWith(
                        top: 30,
                        bottom: 20,
                      ),
                      width: MediaQuerySingleton.screenSize.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 14,
                                  bottom: 5,
                                ),
                                child: Text(
                                  location,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 14,
                                  bottom: 10,
                                  top: 5,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      getImageAsset("titikJemput.png"),
                                      scale: 3.0,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(getNamedSelectedLocation()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 50,
                            width: MediaQuerySingleton.screenSize.width,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Color(0xFFF3C703),
                                ),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                textStyle: MaterialStateTextStyle.resolveWith(
                                  (states) => GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              onPressed: _onPressLanjutkan,
                              child: Text("Lanjutkan"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onPressLanjutkan() {
    if (!(_selectLocationCubit.state is SelectLocationFocused)) {
      return;
    }
    SelectLocationFocused selectLocationState =
        _selectLocationCubit.state as SelectLocationFocused;

    // move focus to next textfield
    if (selectLocationState.titikJemputFocusNode.hasFocus) {
      selectLocationState.titikJemputFocusNode.unfocus();
      selectLocationState.titikTujuanFocusNode.requestFocus();
    } else {
      selectLocationState.titikTujuanFocusNode.unfocus();
    }

    _mapCubit.selectLocationFromMarker(selectLocationState.titikJemputFocus,
        selectLocationState.titikTujuanFocus);
  }
}
