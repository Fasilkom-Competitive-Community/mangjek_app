import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:mangjek_app/app/models/directions.dart';
// import 'package:mangjek_app/resources/pages/order_details/widgets/directions_repository.dart';

class BuildMapBackground extends StatefulWidget {
  const BuildMapBackground({super.key});

  @override
  State<BuildMapBackground> createState() => _BuildMapBackgroundState();
}

class _BuildMapBackgroundState extends State<BuildMapBackground>
    with SingleTickerProviderStateMixin {
  List<LatLng> latLen = [
    LatLng(-3.2061593, 104.6495857),
    LatLng(-3.2056355, 104.6493621),
    LatLng(-3.205414, 104.6497099),
    LatLng(-3.206011, 104.6500741),
    LatLng(-3.2069635, 104.6494737),
    LatLng(-3.2084966, 104.6504076),
    LatLng(-3.2094825, 104.6494174),
    LatLng(-3.2138687, 104.6488116),
    LatLng(-3.213868, 104.6477622),
    LatLng(-3.2166912, 104.6477416),
    LatLng(-3.216689, 104.6487719),
  ];

  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};

  // late Directions _info;

  void _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('origin'),
          position: LatLng(-3.2060669464118132, 104.64976338869252),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(title: 'Lokasi Awal'),
        ),
      );
      _markers.add(
        Marker(
          markerId: MarkerId('destination'),
          position: LatLng(-3.217137647194386, 104.64877289784755),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          infoWindow: InfoWindow(title: 'Lokasi Tujuan'),
        ),
      );
    });

    _focusMarkers();

    // final directions = await DirectionsRepository().getDirections(
    //     origin: _markers.first.position, destination: _markers.last.position);
    // setState(() => _info = directions);
  }

  Set<Marker> _createMarkers() {
    return _markers;
  }

  void _focusMarkers() async {
    LatLngBounds bounds;
    if (_markers.isNotEmpty) {
      final LatLng southwest = LatLng(
        _markers.first.position.latitude,
        _markers.first.position.longitude,
      );
      final LatLng northeast = LatLng(
        _markers.last.position.latitude,
        _markers.last.position.longitude,
      );
      bounds = LatLngBounds(southwest: southwest, northeast: northeast);
    } else {
      bounds = LatLngBounds(southwest: LatLng(0, 0), northeast: LatLng(0, 0));
    }

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(
              (((-3.2060669464118132 + -3.217137647194386) / 2) - 0.005),
              ((104.64976338869252 + 104.64877289784755) / 2),
            ), // lokasi awal
            zoom: 15.0, // mengatur orientasi peta relatif terhadap utara
          ),
          markers: _createMarkers(),
          onMapCreated: _onMapCreated,

          // punyo sha
          polylines: {
            Polyline(
              polylineId: const PolylineId('overview_polyline'),
              color: Colors.blue,
              width: 6,
              points:
                  latLen.map((e) => LatLng(e.latitude, e.longitude)).toList(),
            )
          },

          // Punyo bintang
          // polylines: {
          //   if (_info != null)
          //     Polyline(
          //       polylineId: const PolylineId('overview_polyline'),
          //       color: Colors.blue,
          //       width: 5,
          //       points: _info.polylinePoints
          //           .map((e) => LatLng(e.latitude, e.longitude))
          //           .toList(),
          //     )
          // },
        ),
        // if (_info != null)
        //   Positioned(
        //       top: 20,
        //       child: Container(
        //         padding:
        //             const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
        //         decoration: BoxDecoration(
        //             color: Colors.yellowAccent,
        //             borderRadius: BorderRadius.circular(20.0),
        //             boxShadow: const [
        //               BoxShadow(
        //                   color: Colors.black26,
        //                   offset: Offset(0, 2),
        //                   blurRadius: 6.0)
        //             ]),
        //         child: Text(
        //           '${_info.totalDistance}, ${_info.totalDuration}',
        //           style: const TextStyle(
        //             fontSize: 16.0,
        //             fontWeight: FontWeight.w600,
        //           ),
        //         ),
        //       ))
      ],
    );
  }
}
