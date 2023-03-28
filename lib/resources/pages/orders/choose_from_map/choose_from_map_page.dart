import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mangjek_app/app/extensions/constructor.dart' as cons;
import 'package:mangjek_app/app/bloc/home/map/map_cubit.dart';
import 'package:mangjek_app/app/bloc/home/map_camera/map_camera_cubit.dart';
import 'package:mangjek_app/app/bloc/home/select_location/select_location_cubit.dart';
import 'package:mangjek_app/app/controllers/controller.dart';
import 'package:mangjek_app/app/singleton/media_query.dart';
import 'package:mangjek_app/app/utils/debouncer.dart';
import 'package:mangjek_app/app/singleton/location_plugin.dart';
import 'package:mangjek_app/routes/constant.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:sizer/sizer.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  late double lat, long;
  Object dataValueJemput = {};
  Object dataValueTujuan = {};
  String userLocation = '';
  bool appearLoading = true, appearScreen = false;

  late LatLng centerMarkerLocation;
  Debouncer onMapCameraMoveDebouncer = Debouncer(milliseconds: 200);

  Future<void> getUserCurrentLocation() async {
    Location location = LocationPluginSingleton.getLocationPlugin();
    try {
      await location.getLocation().then((value) {
        setState(() {
          lat = value.latitude!;
          long = value.longitude!;
          centerMarkerLocation = LatLng(lat, long);
          appearScreen = true;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAddressFromCenterMarker() async {
    try {
      GeoData data = await Geocoder2.getDataFromCoordinates(
          latitude: centerMarkerLocation.latitude,
          longitude: centerMarkerLocation.longitude,
          googleMapApiKey: "AIzaSyDIcTGa61FUTuSvoN1W5oRaLlF3K-Bfbmo");
      setState(() {
        userLocation = data.address;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getUserCurrentLocation();
  }

  @override
  init() async {
    super.init();
    _selectLocationCubit = context.read<SelectLocationCubit>();
    isTitikJemput = widget.data();
  }

  final Completer<GoogleMapController> _mapCompleterController =
      Completer<GoogleMapController>();
  GoogleMapController? _mapController;

  void _onCameraMove(CameraPosition cameraPosition) {
    setState(() {
      lat = cameraPosition.target.latitude;
      long = cameraPosition.target.longitude;
      appearLoading = true;
    });
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
        Future.delayed(Duration(seconds: 3), () {
          setState(() {
            centerMarkerLocation = LatLng(lat, long);
            getAddressFromCenterMarker();
            appearLoading = false;
          });
        });
      },
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
        body: (appearScreen)
            ? Stack(
                children: [
                  // map
                  _buildMap(),
                  // center map marker
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      cons.assetsChooseLocation,
                      height: 45,
                      width: 45,
                      scale: 1.6,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: cons.colorBackgroundSplashTwo,
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
                    child:
                        BlocBuilder<SelectLocationCubit, SelectLocationState>(
                            builder: (context, state) {
                      return showChooseLocationBottomWidget();
                    }),
                  ),
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          cons.colorBackgroundSplashTwo),
                      backgroundColor: Colors.grey[300],
                      strokeWidth: 6,
                    ),
                    SizedBox(height: 15),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: cons.sizePadding),
                      child: Text(
                        "Kami sedang memproses Mapnya,\n mohon ditunggu sebentar yaa:)",
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void _onPressLanjutkan() async {
    final prefs = await SharedPreferences.getInstance();
    if (!appearLoading) {
      if (isTitikJemput) {
        setState(() {
          dataValueJemput = {
            'latitude': lat,
            'longtitude': long,
            'address': userLocation
          };
        });
        prefs.setString('dataJemput', dataValueJemput.toString());
      } else {
        setState(() {
          dataValueTujuan = {
            'latitude': lat,
            'longtitude': long,
            'address': userLocation
          };
        });
        prefs.setString('dataTujuan', dataValueTujuan.toString());
      }
    }
    print("Ini adalah datanya, Jemput : " +
        prefs.getString('dataJemput')! +
        " dan Tujuan " +
        prefs.getString('dataTujuan')!);

    if (prefs.getString('dataJemput')!.contains('latitude') &&
        prefs.getString('dataTujuan')!.contains('latitude')) {
      // Route Page Here
      routeTo(ROUTE_HOME_PAGE);
      prefs.setString('dataJemput', '');
      prefs.setString('dataTujuan', '');
    } else {
      pop();
    }
  }

  String getNamedSelectedLocation() {
    return userLocation;
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
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                location,
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
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
                            Expanded(
                              child: (!appearLoading)
                                  ? Text(getNamedSelectedLocation())
                                  : LinearProgressIndicator(
                                      color: cons.colorBackgroundSplashTwo,
                                      minHeight: 3,
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 50,
                    width: MediaQuerySingleton.screenSize.width,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                          (states) => (!appearLoading)
                              ? Color(0xFFF3C703)
                              : Color.fromARGB(255, 202, 202, 202),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(cons.borderRadius),
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
