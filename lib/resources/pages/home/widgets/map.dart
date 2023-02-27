import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mangjek_app/app/bloc/home/map/map_cubit.dart';
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

  final Map<MarkerId, Marker> mapMarkers = Map();

  @override
  init() async {
    super.init();
    initMapMarkers();
    widget._mapCubit.stream.listen(_onLocationChanges);
  }

  void initMapMarkers() {}

  GoogleMapController? _mapController;

  void _onCameraMove(CameraPosition cameraPosition) {
    onMapCameraMoveDebouncer.run(() {
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

    return GoogleMap(
      mapType: MapType.normal,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      zoomControlsEnabled: true,
      initialCameraPosition: CameraPosition(
        target: centerMarkerLocation,
        zoom: 16.5,
      ),
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
