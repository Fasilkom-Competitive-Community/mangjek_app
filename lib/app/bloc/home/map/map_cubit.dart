import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mangjek_app/app/singleton/location_plugin.dart';
import 'package:mangjek_app/app/utils/map.dart';
import 'package:meta/meta.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());

  late LatLng markerPosition;

  void mapIsReady(LatLng cameraLocation) => emit(MapReady(cameraLocation, true, false));

  void setCurrentMarkerPosition(LatLng markerPosition) {
    this.markerPosition = markerPosition;
  }

  Future<void> moveToCurrentLocation(bool isSource, bool isDestination) async {
    LatLng currentLoc =
        await getCurrentLocation(LocationPluginSingleton.getLocationPlugin());
    emit(MapReady(currentLoc, isSource, isDestination));
  }

  Future<void> selectLocationFromMarker(bool isSource, bool isDestination) async {
    emit(MapReady(markerPosition, isSource, isDestination));
  }
}
