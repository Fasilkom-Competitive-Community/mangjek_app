import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mangjek_app/app/bloc/globals/init.dart';
import 'package:mangjek_app/app/bloc/home/map/map_cubit.dart';
import 'package:mangjek_app/app/bloc/home/map_camera/map_camera_cubit.dart';
import 'package:mangjek_app/app/bloc/home/select_location/select_location_cubit.dart';
import 'package:mangjek_app/app/controllers/controller.dart';
import 'package:mangjek_app/app/singleton/media_query.dart';
import 'package:mangjek_app/app/utils/debouncer.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:sizer/sizer.dart';

class ChooseFromMapPage extends NyStatefulWidget {
  final Controller controller = Controller();

  ChooseFromMapPage({Key? key}) : super(key: key);

  @override
  State<ChooseFromMapPage> createState() => _ChooseFromMapPageState();
}

class _ChooseFromMapPageState extends NyState<ChooseFromMapPage> {
  late SelectLocationCubit _selectLocationCubit;
  late MapCubit _mapCubit;
  late MapCameraCubit _mapCameraCubit;
  late bool isTitikJemput;

  @override
  init() async {
    super.init();
    _selectLocationCubit = context.read<SelectLocationCubit>();
    isTitikJemput = widget.data();
  }

  LatLng centerMarkerLocation = LatLng(-3.2189977434045636, 104.65166153632049);

  Debouncer onMapCameraMoveDebouncer = Debouncer(milliseconds: 200);

  final Completer<GoogleMapController> _mapCompleterController =
      Completer<GoogleMapController>();
  GoogleMapController? _mapController;

  void _onCameraMove(CameraPosition cameraPosition) {
    onMapCameraMoveDebouncer.run(() {
      _mapCameraCubit.stopCamera();
      _mapCubit.setCurrentMarkerPosition(cameraPosition.target);
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapCompleterController.complete(controller);
    _mapController = controller;

    _mapCubit.mapIsReady(centerMarkerLocation);
    _mapCubit.moveToCurrentLocation(true, false);
  }

  Widget _buildMap() {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      zoomControlsEnabled: true,
      initialCameraPosition: CameraPosition(
        target: centerMarkerLocation,
        zoom: 16.5,
      ),
      onCameraMoveStarted: () {
        _mapCameraCubit.moveCamera();
      },
      onMapCreated: _onMapCreated,
      onCameraMove: _onCameraMove,
      mapToolbarEnabled: false,
      onTap: (loc) {},
      onCameraIdle: () {
        print('Camera Iddle');
      },
      polylines: {},
      // markers: mapMarkers.values.toSet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    _selectLocationCubit = context.read<SelectLocationCubit>();
    _mapCubit = context.read<MapCubit>();
    _mapCameraCubit = context.read<MapCameraCubit>();

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // map
            _buildMap(),

            // center map marker
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                getImageAsset("choose_location.png"),
                height: 45,
                width: 45,
                scale: 1.6,
              ),
            ),

            // app bar
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                  ),
                ),
                height: 8.h,
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: MediaQuerySingleton.screenSize.width,
                  child: IconButton(
                    onPressed: () {
                      pop();
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: BlocBuilder<SelectLocationCubit, SelectLocationState>(
                  builder: (context, state) {
                return showChooseLocationBottomWidget();
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _onPressLanjutkan() {
    // move focus to next textfield
    pop();
  }

  String getNamedSelectedLocation() {
    return "Fasilkom, Indralaya";
  }

  Widget showChooseLocationBottomWidget() {
    String location = isTitikJemput ? "Lokasi Jemput" : "Lokasi Tujuan";
    return Wrap(
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
                              getImageAsset(
                                isTitikJemput
                                    ? "titikJemput.png"
                                    : "tujuan.png",
                              ),
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
    );
  }
}
