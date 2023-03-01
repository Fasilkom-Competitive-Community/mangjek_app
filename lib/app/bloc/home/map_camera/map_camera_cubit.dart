import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'map_camera_state.dart';

class MapCameraCubit extends Cubit<MapCameraState> {
  MapCameraCubit() : super(MapCameraInitial());

  void moveCamera() {
    emit(MapCameraMoved());
  }

  void stopCamera() {
    emit(MapCameraStop());
  }
}
