import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangjek_app/app/bloc/home/map/map_cubit.dart';
import 'package:mangjek_app/app/bloc/home/map_camera/map_camera_cubit.dart';
import 'package:mangjek_app/app/bloc/home/select_location/select_location_cubit.dart';

SelectLocationCubit selectLocationCubit = SelectLocationCubit();
MapCubit mapCubit = MapCubit();
MapCameraCubit mapCameraCubit = MapCameraCubit();

final GlobalProviders = [
  BlocProvider<SelectLocationCubit>(
    create: (context) => selectLocationCubit,
  ),
  BlocProvider<MapCubit>(
    create: (context) => mapCubit,
  ),
  BlocProvider<MapCameraCubit>(
    create: (context) => mapCameraCubit,
  ),
];
