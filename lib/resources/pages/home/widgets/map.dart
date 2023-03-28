import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mangjek_app/app/bloc/home/map/map_cubit.dart';
import 'package:mangjek_app/app/bloc/home/map_camera/map_camera_cubit.dart';
import 'package:mangjek_app/app/utils/debouncer.dart';
import 'package:nylo_framework/nylo_framework.dart';

class MapWidget extends StatefulWidget {
  MapWidget(this._mapCubit, {super.key});

  final MapCubit _mapCubit;

  @override
  State<MapWidget> createState() => _MapState();
}

class _MapState extends NyState<MapWidget> {
  LatLng centerMarkerLocation = LatLng(-3.2189977434045636, 104.65166153632049);

  Debouncer onMapCameraMoveDebouncer = Debouncer(milliseconds: 200);

  final Completer<GoogleMapController> _mapCompleterController =
      Completer<GoogleMapController>();

  late MapCubit _mapCubit;
  late MapCameraCubit _mapCameraCubit;

  final Map<MarkerId, Marker> mapMarkers = Map();

  late StreamSubscription _onLocationChangesStreamSubs;

  @override
  init() async {
    super.init();
    initMapMarkers();
    _onLocationChangesStreamSubs =
        widget._mapCubit.stream.listen(_onLocationChanges);
  }

  @override
  void dispose() {
    super.dispose();
    _mapController?.dispose();
    _onLocationChangesStreamSubs.cancel();
    onMapCameraMoveDebouncer.cancel();
  }

  void initMapMarkers() {}

  GoogleMapController? _mapController;
  bool isFirstCameraMove = true;

  void _onCameraMove(CameraPosition cameraPosition) {
    onMapCameraMoveDebouncer.run(() {
      if (isFirstCameraMove) {
        isFirstCameraMove = false;
      } else {
        _mapCameraCubit.stopCamera();
      }

      widget._mapCubit.setCurrentMarkerPosition(cameraPosition.target);
    });
  }

  void _onLocationChanges(MapState state) {
    if (state is MapReady) {
      animateToCurrentLocation(state);
    }
  }

  void animateToCurrentLocation(MapReady state) {
    if (_mapController == null) {
      return;
    }

    _mapController!.animateCamera(CameraUpdate.newLatLng(
      state.selectedLocation,
    ));
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapCompleterController.complete(controller);
    _mapController = controller;

    _mapCubit.mapIsReady(centerMarkerLocation);
    _mapCubit.moveToCurrentLocation(true, false);
  }

  @override
  Widget build(BuildContext context) {
    _mapCubit = context.read<MapCubit>();
    _mapCameraCubit = context.read<MapCameraCubit>();

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
      onCameraMove: _onCameraMove,
      mapToolbarEnabled: false,
      onTap: (loc) {},
      onCameraIdle: () {
        print('Camera Iddle');
      },
      polylines: {},
      markers: mapMarkers.values.toSet(),
      onMapCreated: _onMapCreated,
    );
  }
}
