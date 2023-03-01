part of 'map_camera_cubit.dart';

abstract class MapCameraState extends Equatable {
  const MapCameraState();

  @override
  List<Object> get props => [];
}

class MapCameraInitial extends MapCameraState {}
class MapCameraStop extends MapCameraState {}
class MapCameraMoved extends MapCameraState {}
