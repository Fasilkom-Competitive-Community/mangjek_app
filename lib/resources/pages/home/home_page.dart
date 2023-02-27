import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:mangjek_app/app/bloc/home/map/map_cubit.dart';
import 'package:mangjek_app/app/bloc/home/select_location/select_location_cubit.dart';
import 'package:mangjek_app/app/singleton/location_plugin.dart';
import 'package:mangjek_app/resources/pages/home/widgets/bottom_home_widget.dart';
import 'package:mangjek_app/resources/pages/home/widgets/map.dart' as home_map;
import 'package:mangjek_app/resources/pages/home/widgets/top_select_location_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';

class HomePage extends NyStatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends NyState<HomePage> {
  @override
  init() async {
    super.init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // static const CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14.4746,
  // );

  // LocationData? currentLocation;
  // String _address = "";
  // String _alamatJemput = "Titik Jemput";
  // String _alamatTujuan = "Lokasi Tujuan";
  // LatLng? targetLokasi;

  // LatLng srcLoc = LatLng(-3.2189977434045636, 104.65166153632049);
  // LatLng trgLoc = LatLng(-3.2189977434045636, 104.65166153632049);
  // LatLng destLoc = LatLng(-3.2100767532888166, 104.64794354925911);

  // LatLng jemput = LatLng(-3.2189977434045636, 104.65166153632049);
  // double distance = 0.0;
  // Map<PolylineId, Polyline> polylines = {};
  // List<LatLng> polyLineCoordinates = [];
  // bool _markerTengah = false;

  // Future<void> getAddressFromCenterMarker() async {
  //   try {
  //     GeoData data = await Geocoder2.getDataFromCoordinates(
  //         latitude: trgLoc.latitude,
  //         longitude: trgLoc.longitude,
  //         googleMapApiKey: "AIzaSyDIcTGa61FUTuSvoN1W5oRaLlF3K-Bfbmo");

  //     _address = data.address;
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // void getPolyPoints() async {
  //   polyLineCoordinates.clear();
  //   if (srcLocState == null || dstLocState == null) {
  //     return;
  //   }

  //   PolylinePoints polylinePoints = PolylinePoints();
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     'AIzaSyDIcTGa61FUTuSvoN1W5oRaLlF3K-Bfbmo',
  //     PointLatLng(dstLocState!.latitude, dstLocState!.longitude),
  //     PointLatLng(srcLocState!.latitude, srcLocState!.longitude),
  //     travelMode: TravelMode.driving,
  //   );

  //   if (result.points.isNotEmpty) {
  //     for (var point in result.points) {
  //       polyLineCoordinates.add(LatLng(point.latitude, point.longitude));
  //     }
  //   } else {
  //     print(result.errorMessage);
  //   }

  //   //polulineCoordinates is the List of longitute and latidtude.
  //   double totalDistance = 0;
  //   for (var i = 0; i < polyLineCoordinates.length - 1; i++) {
  //     totalDistance += calculateDistance(
  //       polyLineCoordinates[i].latitude,
  //       polyLineCoordinates[i].longitude,
  //       polyLineCoordinates[i + 1].latitude,
  //       polyLineCoordinates[i + 1].longitude,
  //     );
  //   }
  //   print(totalDistance);

  //   setState(() {
  //     distance = totalDistance;
  //   });

  //   //add to the list of poly line coordinates
  //   addPolyLine(polyLineCoordinates);
  // }

  // addPolyLine(List<LatLng> polylineCoordinates) {
  //   PolylineId id = PolylineId("poly");
  //   Polyline polyline = Polyline(
  //     polylineId: id,
  //     color: Colors.deepPurpleAccent,
  //     points: polylineCoordinates,
  //     width: 8,
  //   );
  //   polylines[id] = polyline;
  //   setState(() {});
  // }

  // double calculateDistance(lat1, lon1, lat2, lon2) {
  //   var p = 0.017453292519943295;
  //   var a = 0.5 -
  //       cos((lat2 - lat1) * p) / 2 +
  //       cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
  //   return 12742 * asin(sqrt(a));
  // }

  // void getCurrentLocation() {
  //   Location location = Location();

  //   location.getLocation().then((location) {
  //     setState(() {
  //       currentLocation = location;
  //     });
  //   });
  //   location.onLocationChanged.listen((newLoc) {
  //     setState(() {
  //       currentLocation = newLoc;
  //     });
  //   });
  // }

  // bool isMarkerSrcLocVisible = false;
  // bool isMarkerDstLocVisible = false;
  // LatLng? dstLocState;
  // LatLng? srcLocState;

  // Debouncer onMapCameraMoveDebouncer = Debouncer(milliseconds: 200);

  void showDialogLocationRejected() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Aplikasi hanya dapat dijalankan dengan akses lokasi"),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  locationGranted = false;
                  if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  } else if (Platform.isIOS) {
                    exit(0);
                  }
                });
              },
              child: const Text("Close"),
            )
          ],
        );
      },
    );
  }

  bool locationGranted = true;

  Future<void> tryToAccessLocation() async {
    Location locationPlugin = LocationPluginSingleton.getLocationPlugin();
    PermissionStatus statusPermission = await locationPlugin.hasPermission();
    if (statusPermission == PermissionStatus.denied ||
        statusPermission == PermissionStatus.deniedForever) {
      PermissionStatus statusPermission =
          await locationPlugin.requestPermission();

      if (statusPermission == PermissionStatus.denied ||
          statusPermission == PermissionStatus.deniedForever) {
        showDialogLocationRejected();
        return;
      }
    }

    bool isServiceEnabled = await locationPlugin.serviceEnabled();

    if (!isServiceEnabled) {
      isServiceEnabled = await locationPlugin.requestService();
    }

    if (!isServiceEnabled) {
      // not have access to location service
      showDialogLocationRejected();

      return;
    }

    locationGranted = true;
  }

  @override
  Widget build(BuildContext context) {
    tryToAccessLocation();

    if (!locationGranted) {
      showDialogLocationRejected();
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider<SelectLocationCubit>(
              create: (context) => SelectLocationCubit(),
            ),
            BlocProvider(
              create: (context) => MapCubit(),
            ),
          ],
          child: Builder(builder: (context) {
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
          }),
        ),
      ),
    );
  }
}
